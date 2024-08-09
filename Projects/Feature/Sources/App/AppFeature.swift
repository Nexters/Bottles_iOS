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
      state.login = nil
      state.mainTab = MainTabViewFeature.State()
      return .none
      
    case let .loginCheckCompleted(isLoggedIn):
      if isLoggedIn {
        state.mainTab = MainTabViewFeature.State()
      } else {
        state.login = LoginFeature.State()
      }
      return .none
      
    case .login(.delegate(.createOnboardingProfileDidCompleted)):
      state.login = nil
      state.mainTab = MainTabViewFeature.State()
      return .none
      
    case let .mainTab(.delegate(delegate)):
      switch delegate {
      case .logoutDidCompleted, .withdrawalDidCompleted:
        state.login = .init()
        state.mainTab = nil
        return .none
      }
      
    default:
      return .none
    }
  }
}
