//
//  AppFeature.swift
//  Feature
//
//  Created by JongHoon on 7/23/24.
//

import Foundation

import FeatureLoginInterface
import FeatureLogin

import ComposableArchitecture

@Reducer
public struct AppFeature {
  @ObservableState
  public struct State: Equatable {
    public var appDelegate: AppDelegateFeature.State
    var tabView: MainTabViewFeature.State?
    var login: LoginFeature.State?
    
    public init() {
      self.appDelegate = .init()
    }
  }
  
  public enum Action {
    case onAppear
    case loginCheckComplted(isLoggedIn: Bool)
    case appDelegate(AppDelegateFeature.Action)
    case tabView(MainTabViewFeature.Action)
    case login(LoginFeature.Action)
  }
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce(feature)
      .ifLet(\.tabView, action: \.tabView) {
        MainTabViewFeature()
      }
      .ifLet(\.login, action: \.login) {
        LoginFeature()
      }
  }
  
  private func feature(
    state: inout State,
    action: Action
  ) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      return .run { send in
        try await Task.sleep(nanoseconds: 2500_000_000)
        let isLoggedIn = true
        await send(.loginCheckComplted(isLoggedIn: isLoggedIn), animation: .default)
      }
      
    case let .loginCheckComplted(isLoggedIn):
      switch isLoggedIn {
      case true:
        state.tabView = MainTabViewFeature.State()
      case false:
        state.login = LoginFeature.State()
      }
      return .none
      
    case .appDelegate(_):
      return .none
      
    case .tabView:
      return .none
      
    case .login:
      return .none
    }
  }
}


