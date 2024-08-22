//
//  GeneralLoginFeature.swift
//  FeatureLoginInterface
//
//  Created by JongHoon on 8/10/24.
//

import Foundation

import CoreToastInterface
import DomainAuth

import ComposableArchitecture

extension GeneralLogInFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      @Dependency(\.authClient) var authClient
      @Dependency(\.dismiss) var dismiss
      @Dependency(\.toastClient) var toastClient
      
      switch action {
      case .onAppear:
        return .none
        
      case .webViewLoadingDidCompleted:
        state.isShowLoadingProgressView = false
        return .none
        
      case let .presentToastDidRequired(message):
        toastClient.presentToast(message: message)
        return .none
        
      case let .loginDidCompleted(accessToken, refreshToken, isCompletedOnboardingIntroduction):
        return .send(.delegate(.generalLogInDidSucess(.init(
          token: .init(
            accessToken: accessToken,
            refershToken: refreshToken
          ),
          isSignUp: true,
          isCompletedOnboardingIntroduction: isCompletedOnboardingIntroduction
        ))))
        
      case .closeButtonDidTapped:
        return .run { _ in
          await dismiss()
        }
        
      case .binding, .delegate:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}

