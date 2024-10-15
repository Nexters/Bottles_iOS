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
      switch action {
      case let .sentBottleTapped(url):
        return .send(.delegate(.sentBottleTapped(url: url)))
        
      default:
        return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
