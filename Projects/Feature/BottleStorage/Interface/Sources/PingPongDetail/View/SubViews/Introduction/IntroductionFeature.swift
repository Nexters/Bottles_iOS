//
//  IntroductionFeature.swift
//  FeatureBottleStorage
//
//  Created by JongHoon on 8/11/24.
//

import Foundation

import CoreLoggerInterface

import ComposableArchitecture

extension IntroductionFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
        
      case let .profileFetched(userProfile):
        state.userProfile = userProfile
        return .none
        
      case let .introductionFetched(introductions):
        state.introductions = introductions
        return .none
        
      case .binding:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
