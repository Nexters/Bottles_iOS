//
//  AppFeature.swift
//  Feature
//
//  Created by JongHoon on 7/23/24.
//

import Foundation

import FeatureLoginInterface
import DomainAuth

import ComposableArchitecture

@Reducer
public struct AppFeature {
  @Dependency(\.authClient) var authClient

  enum Root {
    case Login
    case MainTab
  }
  
  @ObservableState
  public struct State: Equatable {
    public var appDelegate: AppDelegateFeature.State
    var mainTab: MainTabViewFeature.State?
    var login: LoginFeature.State?
    
    public init() {
      self.appDelegate = .init()
    }
  }
  
  public enum Action {
    case onAppear
    case appDelegate(AppDelegateFeature.Action)
    case mainTab(MainTabViewFeature.Action)
    case login(LoginFeature.Action)
    case loginCheckCompleted(isLoggedIn: Bool)
  }
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.appDelegate, action: \.appDelegate) {
      AppDelegateFeature()
    }
    Reduce(feature)
      .ifLet(\.mainTab, action: \.mainTab) {
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
      let isLoggedIn = authClient.checkTokenIsExist()
      return .send(.loginCheckCompleted(isLoggedIn: isLoggedIn))
      
    case .login(.goToMainTab):
      return changeRoot(.MainTab, state: &state)
      
    case let .loginCheckCompleted(isLoggedIn):
      if isLoggedIn {
        return changeRoot(.MainTab, state: &state)
      } else {
        return changeRoot(.Login, state: &state)
      }
      
    case .login(.delegate(.createOnboardingProfileDidCompleted)):
      return changeRoot(.MainTab, state: &state)
      
    case let .mainTab(.delegate(delegate)):
      switch delegate {
      case .logoutDidCompleted, .withdrawalDidCompleted:
        return changeRoot(.Login, state: &state)
      }
      
    default:
      return .none
    }
  }
  
  private func changeRoot(_ root: Root, state: inout State) -> Effect<Action> {
    switch root {
    case .Login:
      state.login = LoginFeature.State()
      state.mainTab = nil
    case .MainTab:
      state.login = nil
      state.mainTab = MainTabViewFeature.State()
    }
    
    return .none
  }
}
