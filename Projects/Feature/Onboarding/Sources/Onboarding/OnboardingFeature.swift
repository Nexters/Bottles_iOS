//
//  OnboardingFeature.swift
//  FeatureOnboarding
//
//  Created by JongHoon on 7/31/24.
//

import Foundation

import FeatureOnboardingInterface
import CoreLoggerInterface

import ComposableArchitecture

extension OnboardingFeature
{
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
        
      case .closeButtonDidTap:
        // TODO: close webview
        return .none
        
      case let .presentToastDidRequired(message):
        // TODO: present toast
        return .none
        
      case .createProfileDidCompleted:
        // TODO: present main tab view
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
