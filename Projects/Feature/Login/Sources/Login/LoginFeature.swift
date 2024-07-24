//
//  LoginFeature.swift
//  FeatureLogin
//
//  Created by JongHoon on 7/25/24.
//

import Foundation

import FeatureLoginInterface

import ComposableArchitecture

extension LoginFeature {
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

