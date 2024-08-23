//
//  StartGuideFeature.swift
//  FeatureGuideInterface
//
//  Created by 임현규 on 8/23/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct StartGuideFeature {
  private let reducer: Reduce<State, Action>
  
  init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action {
    case doneButtonDidTapped
    case backButtonDidTapped
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}

extension StartGuideFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .doneButtonDidTapped:
        return .none
        
      case .backButtonDidTapped:
        return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
