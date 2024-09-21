//
//  AlertSettingFeature.swift
//  FeatureMyPageInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation

import ComposableArchitecture

extension AlertSettingFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onLoad:
        return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
