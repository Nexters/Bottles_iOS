//
//  GuideRootFeature.swift
//  FeatureGuideInterface
//
//  Created by 임현규 on 8/22/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct GuideRootFeature {
  
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  public struct State: Equatable {
    
  }
  
  public enum Action {
    
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
