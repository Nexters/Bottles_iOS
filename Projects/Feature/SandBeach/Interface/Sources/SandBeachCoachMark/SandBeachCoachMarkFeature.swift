//
//  SandBeachCoachMarkFeature.swift
//  FeatureSandBeachInterface
//
//  Created by 임현규 on 10/28/24.
//

import ComposableArchitecture

extension SandBeachCoachMarkFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .coachMarkDidTapped:
        state.count += 1
        
        if state.count == 3 {
          return .send(.delegate(.coachMarkDidCompleted))
        } else {
          return .none
        }
        
      case .delegate:
        return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
