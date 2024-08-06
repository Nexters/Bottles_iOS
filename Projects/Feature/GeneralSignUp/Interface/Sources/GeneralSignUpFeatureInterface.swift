//
//  GeneralSignUpFeatureInterface.swift
//  FeatureGeneralSignUpInterface
//
//  Created by JongHoon on 8/4/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct GeneralSignUpFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action {
    case onAppear
    case closeButtonDidTap
    case presentToastDidRequired(message: String)
    case signUpDidCompleted(accessToken: String, refreshToken: String)
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
