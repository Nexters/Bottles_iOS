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
import CoreLoggerInterface
import CoreKeyChainStore

import ComposableArchitecture

@Reducer
public struct AppFeature {
  @Dependency(\.profileClient) var profileClient
  @Dependency(\.bottleClient) var bottleClient
  @Dependency(\.authClient) var authClient
  
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
      return .run(operation: { send in
        let isLoggedIn = authClient.checkTokenIsExist()
        await send(.loginCheckComplted(isLoggedIn: true), animation: .default)
        
        // 로그인 상태인 경우 SandBeachFeature.State 업데이트
        if isLoggedIn {
          let userState = try await checkUserState()
          await send(.userStateCheckCompleted(userState))
        }
      }, catch: { error, send in
        KeyChainTokenStore.shared.deleteAll()
        await send(.loginCheckComplted(isLoggedIn: false), animation: .default)
      })
      
      
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

// MARK: - Private Extension
private extension AppFeature {
  func checkUserState() async throws -> SandBeachFeature.UserStateType {
    let isExistIntroduction = try await profileClient.checkExistIntroduction()
    if isExistIntroduction { return .noIntroduction }
    let bottlesCount = try await bottleClient.fetchNewBottlesCount()
    guard let count = bottlesCount else { return .noBottle }
    return .hasBottle(bottleCount: count)
  }
}
