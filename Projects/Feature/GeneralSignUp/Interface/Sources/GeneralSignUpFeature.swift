//
//  GeneralSignUpFeature.swift
//  FeatureGeneralSignUpInterface
//
//  Created by JongHoon on 8/4/24.
//

import Foundation

import CoreToastInterface
import DomainAuthInterface

import ComposableArchitecture

extension GeneralSignUpFeature {
  public init() {
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.toastClient) var toastClient
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
        
      case .webViewLoadingDidCompleted:
        state.isShowLoadingProgressView = false
        return .none
        
      case .closeButtonDidTap:
        return .run { _ in
          await dismiss()
        }
        
      case let .presentToastDidRequired(message):
        toastClient.presentToast(message: message)
        return .none
        
      case let .signUpDidCompleted(accessToken, refreshToken):
        return .send(.delegate(.signUpDidCompleted(.init(
          token: .init(
            accessToken: accessToken,
            refershToken: refreshToken
          ),
          isSignUp: true,
          isCompletedOnboardingIntroduction: false
        ))))
      
      case .binding, .delegate:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
