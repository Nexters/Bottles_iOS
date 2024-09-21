//
//  AccountSettingFeature.swift
//  FeatureMyPageInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation

import DomainUser
import DomainAuth
import DomainUserInterface

import CoreKeyChainStore

import ComposableArchitecture

extension AccountSettingFeature {
  public init() {
    @Dependency(\.userClient) var userClient
    @Dependency(\.authClient) var authClient
    @Dependency(\.dismiss) var dismiss
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onLoad:
        return .none
      
      case let .matchingToggleDidFetched(isOn):
        state.isOnMatchingToggle = isOn
        return .none
        
      case .backButtonDidTapped:
        return .run { _ in
          await dismiss()
        }
        
      case .logoutButtonDidTapped:
        state.destination = .alert(.init(
          title: { TextState("로그아웃") },
          actions: {
            ButtonState(role: .cancel, action: .confirmLogOut, label: { TextState("로그아웃하기") })
            ButtonState(role: .destructive, action: .dismiss, label: { TextState("취소하기") })
          },
          message: { TextState("정말 로그아웃 하시겠어요?") }
        ))
        return .none
        
      case .withdrawalButtonDidTapped:
        state.destination = .alert(.init(
          title: { TextState("탈퇴하기") },
          actions: {
            ButtonState(role: .cancel, action: .confirmWithdrawal, label: { TextState("탈퇴하기") })
            ButtonState(role: .destructive, action: .dismiss, label: { TextState("계속 이용하기") })
          },
          message: { TextState("탈퇴 시 계정 복구가 어려워요.\n정말 탈퇴하시겠어요?") }
        ))
        return .none
        
      case .binding(\.isOnMatchingToggle):
        return .run { [isOn = state.isOnMatchingToggle] send in
          await send(.toggleDidChanged(alertState: .init(alertType: .randomBottle, enabled: isOn)))
        }
        .debounce(
          id: ID.matcingToggle,
          for: 1.0,
          scheduler: DispatchQueue.main)
        
      case let .toggleDidChanged(alertState):
        return .run { send in
          try await userClient.updateAlertState(alertState: alertState)
        }
        
      case let .destination(.presented(.alert(alert))):
        switch alert {
        case .confirmLogOut:
          return .run { send in
            try await authClient.logout()
            await send(.logoutDidCompleted)
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
        
        case .dismiss:
          return .none
        }
        
      case .logoutDidCompleted:
        return .send(.delegate(.logoutDidCompleted))
        
      case .withdrawalDidCompleted:
        return .send(.delegate(.withdrawalDidCompleted))

      default:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
