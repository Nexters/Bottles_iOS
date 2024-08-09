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
        return .run { send in
          try await authClient.logout()
          await send(.logOutDidCompleted)
        }
        
      case .logOutDidCompleted:
        KeyChainTokenStore.shared.deleteAll()
        return .none
        
      case .withdrawalButtonDidTapped:
        return .run { send in
          try await authClient.withdraw()
          await send(.withdrawalDidCompleted)
        }
        
      case .withdrawalDidCompleted:
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

