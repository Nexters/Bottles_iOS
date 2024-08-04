//
//  GeneralLogInFeature.swift
//  FeatureLoginInterface
//
//  Created by JongHoon on 8/4/24.
//

import Foundation

import FeatureLoginInterface

import ComposableArchitecture

extension GeneralLogInFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
        
      case let .presentToastDidRequired(message):
        // TODO: present toast
        return .none
        
      case let .loginDidCompleted(accessToken, refreshToken):
        // TODO: Login Completed Handling
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
