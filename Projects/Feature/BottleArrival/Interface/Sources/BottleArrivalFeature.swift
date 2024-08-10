//
//  BottleArrivalFeature.swift
//  FeatureBottleArrivalInterface
//
//  Created by 임현규 on 8/11/24.
//

import Foundation

import ComposableArchitecture

extension BottleArrivalFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
        
      case .webViewLoadingDidCompleted:
        state.isLoading = false
        return .none
        
      case .bottelDidAccepted:
        return .send(.delegate(.bottelDidAccepted))
        
      case .closeWebView:
        return .send(.delegate(.closeWebView))
      
      default:
        return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
