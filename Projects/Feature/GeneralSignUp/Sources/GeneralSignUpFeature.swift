//
//  GeneralSignUpFeature.swift
//  FeatureGeneralSignUpInterface
//
//  Created by JongHoon on 8/4/24.
//

import Foundation

import FeatureGeneralSignUpInterface

import ComposableArchitecture

extension GeneralSignUpFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
        
      case .closeButtonDidTap:
        return .none
        
      case let .presentToastDidRequired(message):
        return .none
        
      case let .signUpDidCompleted(accessToken, refreshToken):
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
