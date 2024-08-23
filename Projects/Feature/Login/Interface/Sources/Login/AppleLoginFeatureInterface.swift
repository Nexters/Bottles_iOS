//
//  AppleLoginFeatureInterface.swift
//  FeatureLoginInterface
//
//  Created by 임현규 on 8/23/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct AppleLoginFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }

  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action {
    case signInAppleButtonDidTapped
    case backButtonDidTapped
    case delegate(Delegate)
    
    public enum Delegate {
       case signInAppleButtonDidTapped
    }
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
