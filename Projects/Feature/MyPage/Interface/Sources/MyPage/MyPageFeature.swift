//
//  MyPageFeature.swift
//  FeatureMyPageInterface
//
//  Created by JongHoon on 7/24/24.
//

import Foundation

import DomainAuth
import CoreKeyChainStore
import CoreToastInterface

import ComposableArchitecture

extension MyPageFeature {
  public init() {
    @Dependency(\.authClient) var authClient
    @Dependency(\.toastClient) var toastClient
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
        
      case .webViewLoadingDidCompleted:
        state.isShowLoadingProgressView = false
        return .none
        
      case let .presentToastDidRequired(message):
        toastClient.presentToast(message: message)
        return .none
        
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
          actions: { ButtonState(role: .destructive, action: .confirmWithdrawal, label: { TextState("탈퇴히가") }) },
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
            await send(.withdrawalDidCompleted)
          }
        }
        
      case .binding, .delegate, .destination, .alert:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}

