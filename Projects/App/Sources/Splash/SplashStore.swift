//
//  SplashStore.swift
//  Bottle
//
//  Created by JongHoon on 7/21/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct SplashFeature {
  
  public struct State: Equatable {
  }
  
  public enum Action {
    case viewLoaded
  }
  
  public var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .viewLoaded:
        print("loaded")
        return .none
        
      default:
        return .none
      }
    }
  }
}
