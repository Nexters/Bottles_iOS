//
//  MyPageFeature.swift
//  FeatureMyPageInterface
//
//  Created by JongHoon on 7/24/24.
//

import Foundation

import DomainAuth
import DomainProfile
import CoreKeyChainStore
import CoreToastInterface
import CoreLoggerInterface
import SharedDesignSystem
import ComposableArchitecture

extension MyPageFeature {
  public init() {
    @Dependency(\.authClient) var authClient
    @Dependency(\.toastClient) var toastClient
    @Dependency(\.profileClient) var profileClient
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onLoad:
        state.isShowLoadingProgressView = true
        return .run { send in
          let userProfile = try await profileClient.fetchUserProfile()
          await send(.userProfileDidFetched(userProfile))
        }
        
      case .logOutButtonDidTapped:
        state.destination = .alert(.init(
          title: { TextState("로그아웃") },
          actions: { ButtonState(role: .destructive, action: .confirmLogOut, label: { TextState("로그아웃") }) },
          message: { TextState("정말 로그아웃 하시겠어요?") }
        ))
        return .none
        
      case .logOutDidCompleted:
        KeyChainTokenStore.shared.deleteAll()
        return .send(.delegate(.logoutDidCompleted))
        
      case .withdrawalButtonDidTapped:
        state.destination = .alert(.init(
          title: { TextState("탈퇴하기") },
          actions: { ButtonState(role: .destructive, action: .confirmWithdrawal, label: { TextState("탈퇴하기") }) },
          message: { TextState("탈퇴 시 계정 복구가 어려워요.\n정말 탈퇴하시겠어요?") }
        ))
        return .none
        
      case .withdrawalDidCompleted:
        KeyChainTokenStore.shared.deleteAll()
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
            try await authClient.withdraw()
            if !KeyChainTokenStore.shared.load(property: .AppleUserID).isEmpty {
              // clientSceret 받아오기
              let clientSceret = try await authClient.fetchAppleClientSecret()
              KeyChainTokenStore.shared.save(property: .AppleClientSecret, value: clientSceret)
              try await authClient.revokeAppleLogin()
            }
            await send(.withdrawalDidCompleted)
          }
        }
        
      case .userProfileDidFetched(let userProfile):
        let profileSelect = userProfile.profileSelect
        let userInfo = userProfile.userInfo
        let introduction = userProfile.introduction
        
        Log.debug(userProfile)
        
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
      default:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}

