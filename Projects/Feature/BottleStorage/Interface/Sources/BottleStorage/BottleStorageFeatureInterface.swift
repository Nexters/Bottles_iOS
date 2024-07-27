//
//  BottleStorageFeatureInterface.swift
//  FeatureBottleStorageExample
//
//  Created by JongHoon on 7/24/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct BottleStorageFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action {
    case onAppear
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
