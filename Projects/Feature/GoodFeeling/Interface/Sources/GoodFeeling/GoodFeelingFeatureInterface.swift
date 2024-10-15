//
//  GoodFeelingFeature.swift
//  FeatureGoodFeelingInterface
//
//  Created by JongHoon on 10/6/24.
//

import Foundation

import ComposableArchitecture

extension GoodFeelingFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      return .none
    }
    
    self.init(reducer: reducer)
  }
}
