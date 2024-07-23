//
//  HomeFeature.swift
//  FeatureHome
//
//  Created by JongHoon on 7/23/24.
//

import ComposableArchitecture

import FeatureHomeInterface

@Reducer
struct HomeFeature {
  public struct State: Equatable {
  }
  
  public enum Action {
    case viewLoaded
  }
  
  public var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .viewLoaded:
        return .run { _ in
          
        }
      }
    }
  }
}
