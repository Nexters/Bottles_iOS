//
//  SandBeachCoachMarkFeatureInterface.swift
//  FeatureSandBeachInterface
//
//  Created by 임현규 on 10/28/24.
//

import ComposableArchitecture

@Reducer
public struct SandBeachCoachMarkFeature {
  private let reducer: Reduce<State, Action>
  
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }

  @ObservableState
  public struct State: Equatable {
    public var count: Int = 0

    public init() {}
  }
  
  public enum Action {
    case coachMarkDidTapped
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
