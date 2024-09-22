//
//  MyPageFeature.swift
//  FeatureMyPageInterface
//
//  Created by JongHoon on 7/24/24.
//

import Foundation

import DomainAuth
import DomainProfile
import DomainUserInterface
import DomainApplication

import CoreKeyChainStore
import CoreToastInterface
import CoreLoggerInterface
import CoreURLHandlerInterface

import SharedDesignSystem

import ComposableArchitecture

extension MyPageFeature {
  public init() {
    @Dependency(\.authClient) var authClient
    @Dependency(\.toastClient) var toastClient
    @Dependency(\.profileClient) var profileClient
    @Dependency(\.userClient) var userClient
    @Dependency(\.applicationClient) var applicationClient
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onLoad:
        state.isShowLoadingProgressView = true
        return .run { send in
          let userProfile = try await profileClient.fetchUserProfile()
          await send(.userProfileDidFetched(userProfile))
        }
        
      case .onAppear:
        return .run { send in
          let currentAppVersion = applicationClient.fetchCurrentAppVersion()
          let isNeedUpdateApplication = try await applicationClient.checkNeedApplicationUpdate()
          await send(.applicationVersionInfoFetched(currentAppVersion: currentAppVersion, isNeedUpdate: isNeedUpdateApplication))
        } catch: { error, send in
          Log.error(error)
        }
        
      case let .applicationVersionInfoFetched(currentAppVersion, isNeedUpdate):
        state.currentAppVersion = currentAppVersion
        state.isShowApplicationUpdateButton = isNeedUpdate
        return .none
        
      case .logOutButtonDidTapped:
        state.destination = .alert(.init(
          title: { TextState("로그아웃") },
          actions: { ButtonState(role: .destructive, action: .confirmLogOut, label: { TextState("로그아웃") }) },
          message: { TextState("정말 로그아웃 하시겠어요?") }
        ))
        return .none
        
      case .logOutDidCompleted:
        return .send(.delegate(.logoutDidCompleted))
        
      case .withdrawalButtonDidTapped:
        state.destination = .alert(.init(
          title: { TextState("탈퇴하기") },
          actions: { ButtonState(role: .destructive, action: .confirmWithdrawal, label: { TextState("탈퇴하기") }) },
          message: { TextState("탈퇴 시 계정 복구가 어려워요.\n정말 탈퇴하시겠어요?") }
        ))
        return .none
        
      case .withdrawalDidCompleted:
        return .send(.delegate(.withdrawalDidCompleted))
        
      case let .destination(.presented(.alert(alert))):
        switch alert {
        case .confirmLogOut:
          return .run { send in
            try await authClient.logout()
            await send(.logOutDidCompleted)
          }
          
        case .confirmWithdrawal:
          return .run { send in
            await send(.delegate(.withdrawalButtonDidTapped))
            try await authClient.withdraw()
            if !KeyChainTokenStore.shared.load(property: .AppleUserID).isEmpty {
              // clientSceret 받아오기
              let clientSceret = try await authClient.fetchAppleClientSecret()
              KeyChainTokenStore.shared.save(property: .AppleClientSecret, value: clientSceret)
              try await authClient.revokeAppleLogin()
            }
            await send(.withdrawalDidCompleted)
          }
          
        case .dismissContactsAlert:
          state.destination = nil
          return .send(.configureLoadingProgressView(isShow: false))
		
        case .dismissContactsAlert:
          state.destination = nil
          URLHandler.shared.openURL(urlType: .setting)
          return .none

        case let .confirmBlockContacts(contacts):
          return .run { send in
            try await userClient.updateBlockContacts(contacts: contacts)
            await send(.updatePhoneNumberForBlockCompleted(count: contacts.count))
            await send(.configureLoadingProgressView(isShow: false))
          }
        }
        
      case .userProfileDidFetched(let userProfile):
        let profileSelect = userProfile.profileSelect
        let userInfo = userProfile.userInfo
        let introduction = userProfile.introduction
        
        Log.debug(userProfile)
        state.blockedContactsCount = userInfo.blockedContactsCount
        
        state.keywordItem = [
          ClipItem(
            title: "기본 정보",
            list: [profileSelect.job, profileSelect.mbti, "\(profileSelect.region.city) \(profileSelect.region.state)", "\(profileSelect.height)", profileSelect.smoke, profileSelect.alcohol]
          ),
          
          ClipItem(
            title: "나의 성격은",
            list: profileSelect.keyword
          ),
          
          ClipItem(
            title: "내가 푹 빠진 취미는",
            list: (profileSelect.interset.culture ?? [])
            + (profileSelect.interset.entertainment ?? [])
            + (profileSelect.interset.sports ?? [])
            + (profileSelect.interset.etc ?? [])
          )
        ]
        
        state.userInfo = userInfo
        state.introduction = introduction
        state.isShowLoadingProgressView = false

        return .none
      case let .selectedTabDidChanged(selectedTap):
        return .send(.delegate(.selectedTabDidChanged(selectedTap)))
        
      case .userProfileUpdateDidRequest:
        return .run { send in
          let userProfile = try await profileClient.fetchUserProfile()
          await send(.userProfileDidFetched(userProfile))
        }
        
      case .updatePhoneNumberForBlockButtonDidTapped:
        return .run { send in
          await send(.configureLoadingProgressView(isShow: true))
          let contacts = try await userClient.fetchContacts()
          await send(.contactsDidReceived(contacts: contacts))
        } catch: { error, send in
          await send(.configureLoadingProgressView(isShow: false))
          if let userError = error as? UserError {
            switch userError {
            case .requestContactsAccessAuthorityFailed:
              Log.debug("연락처 접근 요정 거부")
            case .contactsAccessDenied:
              await send(.contactsAccessDeniedErrorOccurred)
            }
          }
        }
      
      case let .contactsDidReceived(contacts):
        let count = contacts.count
        state.destination = .alert(.init(
          title: { TextState("연락처 차단") },
          actions: {
            ButtonState(role: .cancel, action: .dismissAlert, label: { TextState("취소하기")})
            ButtonState(role: .destructive, action: .confirmBlockContacts(contacts: contacts), label: { TextState("차단하기")})
          },
          message: { TextState("주소록에 있는 \(count)개의\n전화번호를 차단할까요?") }))
        return .none
        
      case .updateApplicationButtonTapped:
        URLHandler.shared.openURL(urlType: .bottleAppStore)
        return .none
        
      case .updateApplicationButtonTapped:
        URLHandler.shared.openURL(urlType: .bottleAppStore)
        return .none
        
      case let .updatePhoneNumberForBlockCompleted(count):
        toastClient.presentToast(message: "차단이 완료됐어요")
        state.blockedContactsCount = count
        return .none
        
      case .contactsAccessDeniedErrorOccurred:
        state.destination = .alert(.init(
          title: {
            TextState("안내")
          },
          actions: {
            ButtonState(
              action: .dismissContactsAlert,
              label: { TextState("확인") }
            )
          },
          message: {
            TextState("설정 > 개인정보 보호 및 보안 > 연락처에서 '보틀'의 연락처 접근을 허락해 주세요.")
          }
        ))
        return .none
        
      case .profileEditListDidTapped:
        return .send(.delegate(.profileEditListDidTapped))
        
      case .alertSettingListDidTapped:
        return .send(.delegate(.alertSettingListDidTapped))
        
      case .accountSettingListDidTapped:
        return .send(.delegate(.accountSettingListDidTapped))
        
      case .termsOfServiceListDidTapped:
        state.isPresentTerms = true
        state.temrsURL = "https://spiral-ogre-a4d.notion.site/240724-e3676639ea864147bb293cfcda40d99f"
        return .none
        
      case .privacyPolicyListDidTapped:
        state.isPresentTerms = true
        state.temrsURL = "https://spiral-ogre-a4d.notion.site/abb2fd284516408e8c2fc267d07c6421"
        return .none
        
      case .termsWebViewDidDismiss:
        state.isPresentTerms = false
        state.temrsURL = ""
        return .none
        
      case .contactListDidTapped:
        URLHandler.shared.openURL(urlType: .kakaoChannelTalk)
        return .none

      case let .configureLoadingProgressView(isShow):
        state.isShowLoadingProgressView = isShow
        return .none
        
      default:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}

