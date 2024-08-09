//
//  MyPageFeature.swift
//  FeatureMyPageInterface
//
//  Created by JongHoon on 7/24/24.
//

import Foundation

import DomainAuth
import CoreKeyChainStore

import ComposableArchitecture

extension MyPageFeature {
  public init() {
    @Dependency(\.authClient) var authClient
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
        
      case .webViewLoadingCompleted:
        state.isShowLoadingProgressView = false
        return .none
        
      case let .presentToastRequired(message):
        // TODO: present toast
        return .none
        
      case .logOutDidCompleted:
        // TODO: log out handling
        return .none
        
      case .withdrawalButtonDidTap:
        return .run { send in
          try await authClient.withdraw()
          await send(.withdrawalCompleted)
        }
        
      case .withdrawalCompleted:
        KeyChainTokenStore.shared.deleteAll()
        // 화면이동
        return .none
        
      case .binding:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}

