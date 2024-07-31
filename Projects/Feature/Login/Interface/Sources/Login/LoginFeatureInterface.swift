//
//  LoginFeatureInterface.swift
//  FeatureLogin
//
//  Created by JongHoon on 7/24/24.
//

import Foundation

import DomainAuthInterface

import ComposableArchitecture

@Reducer
public struct LoginFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action {
    case onAppear
    case signInKakaoRequest
    case signInKakaoResponse(TaskResult<Token>)
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
