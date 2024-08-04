//
//  GeneralLogInFeatureInterface.swift
//  FeatureLoginInterface
//
//  Created by JongHoon on 8/4/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct GeneralLogInFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action {
    case onAppear
    case presentToastDidRequired(message: String)
    case loginDidCompleted(accessToken: String, refreshToken: String)
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
