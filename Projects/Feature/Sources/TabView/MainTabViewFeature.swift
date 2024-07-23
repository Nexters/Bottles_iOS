//
//  MainTabViewFeature.swift
//  Feature
//
//  Created by JongHoon on 7/22/24.
//

import ComposableArchitecture

@Reducer
public struct MainTabViewFeature {
  
  public struct State: Equatable {
    
    public init() {
      
    }
  }
  
  public enum Action {
    
  }
  
  public var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      default:
        return .none
      }
    }
  }
}
