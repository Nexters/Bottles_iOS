//
//  AlertSettingFeatureInterface.swift
//  FeatureMyPageInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct AlertSettingFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    
  }
  
  public enum Action {
    case onLoad
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
