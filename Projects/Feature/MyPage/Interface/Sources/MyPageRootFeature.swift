//
//  MyPageRootFeature.swift
//  FeatureMyPageInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct MyPageRootFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  
  public enum Path {
    
  }

  public struct State {
    
  }
  
  public enum Action {
    
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}


