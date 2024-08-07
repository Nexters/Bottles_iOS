//
//  BottleStorageFeature.swift
//  FeatureBottleStorage
//
//  Created by JongHoon on 7/25/24.
//

import ComposableArchitecture

extension BottleStorageFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
        
      case let .bottleActiveStateTabButtonTapped(activeState):
        state.selectedActiveStateTab = activeState
        return .none
        
      case .binding:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}

