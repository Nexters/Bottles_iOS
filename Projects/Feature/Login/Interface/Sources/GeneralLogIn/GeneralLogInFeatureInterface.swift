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

extension GeneralLogInFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
        
      case let .presentToastDidRequired(message):
        // TODO: present toast
        return .none
        
      case let .loginDidCompleted(accessToken, refreshToken):
        // TODO: Login Completed Handling
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
