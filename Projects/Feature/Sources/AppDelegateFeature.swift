//
//  AppDelegateFeature.swift
//  Feature
//
//  Created by JongHoon on 7/23/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct AppDelegateFeature {
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action {
    case didFinishLunching
  }
  
  public var body: some ReducerOf<Self> {
    Reduce(feature)
  }
  
  private func feature(
    state: inout State,
    action: Action
  ) -> EffectOf<Self> {
    switch action {
    case .didFinishLunching:
      return .none
    }
  }
}
