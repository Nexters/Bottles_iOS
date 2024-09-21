//
//  MyPageRootFeatureInterface.swift
//  FeatureMyPageInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation

import ComposableArchitecture

extension MyPageRootFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      return .none
    }
    
    self.init(reducer: reducer)
  }
}

