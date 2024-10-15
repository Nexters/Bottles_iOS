//
//  GoodFeelingRootFeatureInterface.swift
//  FeatureGoodFeelingInterface
//
//  Created by JongHoon on 10/6/24.
//

import Foundation

import ComposableArchitecture

extension GoodFeelingRootFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case let .selectedTabDidChanged(selectedTab):
        return .send(.delegate(.selectedTabDidChanged(selectedTab)))
        
      default:
        return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
