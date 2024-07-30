//
//  AppFeature.swift
//  Feature
//
//  Created by JongHoon on 7/23/24.
//

import Foundation

import FeatureLoginInterface
import FeatureSandBeachInterface
import FeatureLogin

import ComposableArchitecture

@Reducer
public struct AppFeature {
  @Dependency(\.profileClient) var profileClient
  @Dependency(\.bottleClient) var bottleClient
  
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
    case userStateCheckCompleted(SandBeachFeature.UserStateType)
    case appDelegate(AppDelegateFeature.Action)
    case tabView(MainTabViewFeature.Action)
    case login(LoginFeature.Action)
  }
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.appDelegate, action: \.appDelegate) {
      AppDelegateFeature()
    }
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
        do {
          // TODO: - Login 상태 처리
          let isLoggedIn = true
          await send(.loginCheckComplted(isLoggedIn: isLoggedIn), animation: .default)
          
          let isExistIntroduction = try await profileClient.checkExistIntroduction()

          if !isExistIntroduction {
            await send(.userStateCheckCompleted(.noIntroduction))
          } else {
            let bottlesCount = try await bottleClient.fetchNewBottlesCount()
            guard let count = bottlesCount else {
              await send(.userStateCheckCompleted(.noBottle))
              return
            }
            await send(.userStateCheckCompleted(.hasBottle(bottleCount: count)))
          }
          
        } catch {
          await send(.loginCheckComplted(isLoggedIn: true), animation: .default)
          await send(.userStateCheckCompleted(.noIntroduction))
        }
      }
      
    case let .loginCheckComplted(isLoggedIn):
      switch isLoggedIn {
      case true:
        state.tabView = MainTabViewFeature.State()
      case false:
        state.login = LoginFeature.State()
      }
      return .none
    case .userStateCheckCompleted(let userState):
      state.tabView?.sandBeach = SandBeachFeature.State(userState: userState)
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
