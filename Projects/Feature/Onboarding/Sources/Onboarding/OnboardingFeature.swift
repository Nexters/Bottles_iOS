//
//  OnboardingFeature.swift
//  FeatureOnboarding
//
//  Created by JongHoon on 7/31/24.
//

import Foundation

import FeatureOnboardingInterface

import ComposableArchitecture

extension OnboardingFeature
{
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
