//
//  OnboardingFeature.swift
//  FeatureOnboarding
//
//  Created by JongHoon on 7/31/24.
//

import Foundation

import CoreLoggerInterface
import CoreToastInterface

import ComposableArchitecture

extension OnboardingFeature {
  public init() {
    @Dependency(\.toastClient) var toastClient
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
        
      case let .presentToastDidRequired(message):
        toastClient.presentToast(message: message)
        return .none
        
      case .webViewLoadingCompleted:
        state.isShowLoadingProgressView = false
        return .none
        
      case .createProfileDidCompleted:
        return .run { send in
          await send(.delegate(.createOnboardingProfileDidCompleted))
        }
      
      case .binding, .delegate:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
