//
//  ProfileSetupFeature.swift
//  FeatureProfileSetup
//
//  Created by 임현규 on 8/5/24.
//

import Foundation

import FeatureProfileSetupInterface

import ComposableArchitecture

extension ProfileSetupFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
      case let .texFieldDidFocused(isFocused):
        state.textFieldState = isFocused ? .active : .focused
        return .none
      case .binding(\.introductionText):
        // TODO: 50자 미만 error state, 50자 이상 active 처리
        // TODO: 300자 초과시 작성 못하게 처리
        return .none
      case .binding(_):
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
