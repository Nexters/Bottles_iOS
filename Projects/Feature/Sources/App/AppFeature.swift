//
//  AppFeature.swift
//  Feature
//
//  Created by JongHoon on 7/23/24.
//

import Foundation
import AuthenticationServices

import FeatureLoginInterface
import FeatureOnboardingInterface

import DomainAuth
import DomainProfile
import CoreKeyChainStore
import CoreLoggerInterface

import ComposableArchitecture

@Reducer
public struct AppFeature {
  @Dependency(\.authClient) var authClient
  @Dependency(\.profileClient) var profileClient
  @Dependency(\.userClient) var userClient
  
  enum Root {
    case Login
    case MainTab
    case Onboarding
  }
  
  @ObservableState
  public struct State: Equatable {
    public var appDelegate: AppDelegateFeature.State
    
    var mainTab: MainTabViewFeature.State?
    var login: LoginFeature.State?
    var onboarding: OnboardingFeature.State?
    
    public init() {
      self.appDelegate = .init()
    }
  }
  
  public enum Action {
    case onAppear
    case appDelegate(AppDelegateFeature.Action)
    case mainTab(MainTabViewFeature.Action)
    case login(LoginFeature.Action)
    case onboarding(OnboardingFeature.Action)
    
    case sceneDidActive
    case appleUserIdDidRevoked
    case loginCheckCompleted(isLoggedIn: Bool)
    case profileSelectExistCheckCompleted(isExist: Bool)
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
      .ifLet(\.onboarding, action: \.onboarding) {
        OnboardingFeature()
      }
  }
  
  private func feature(
    state: inout State,
    action: Action
  ) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      let isAppDeleted = userClient.isAppDeleted()
      let isLoggedIn = authClient.checkTokenIsExist()
      
      if isAppDeleted {
        userClient.updateDeleteState(isDelete: false)
        return .send(.loginCheckCompleted(isLoggedIn: false))
      } else {
        return .send(.loginCheckCompleted(isLoggedIn: isLoggedIn))
      }
      
    case .login(.goToMainTab):
      return changeRoot(.MainTab, state: &state)
      
    case let .loginCheckCompleted(isLoggedIn):
      if isLoggedIn {
        return .run { send in
          let userProfileStatus = try await profileClient.fetchUserProfileSelect()
          let isExistProfileSelect = userProfileStatus == .empty ? false : true
          return await send(.profileSelectExistCheckCompleted(isExist: isExistProfileSelect))
        } catch: { error, send in
          // TODO: - 네트워킹 에러 처리
        }
      } else {
        authClient.removeAllToken()
        return changeRoot(.Login, state: &state)
      }
      
    case let .profileSelectExistCheckCompleted(isExistProfileSelect):
      if isExistProfileSelect {
        return changeRoot(.MainTab, state: &state)
      } else {
        return changeRoot(.Onboarding, state: &state)
      }
    
    // Login Delegate
    case let .login(.delegate(delegate)):
      switch delegate {
      case .createOnboardingProfileDidCompleted:
        return changeRoot(.MainTab, state: &state)
      }
      
    // MainTab Delegate
    case let .mainTab(.delegate(delegate)):
      switch delegate {
      case .logoutDidCompleted, .withdrawalDidCompleted:
        return changeRoot(.Login, state: &state)
      }
    
    // Onboarding Delegate
    case let .onboarding(.delegate(delegate)):
      switch delegate {
      case .createOnboardingProfileDidCompleted:
        return changeRoot(.MainTab, state: &state)
      }
      
    case .sceneDidActive:
      let appleIDProvider = ASAuthorizationAppleIDProvider()
      let userID = KeyChainTokenStore.shared.load(property: .AppleUserID)
      
      if userID.isEmpty { return .none }
      
      return .run { send in
        let credentialState = try await appleIDProvider.credentialState(forUserID: userID)
        
        Log.debug(credentialState)
        switch credentialState {
        case .authorized:
          Log.debug("애플 로그인 인증 성공")
        case .revoked:
          Log.error("애플 로그인 인증 만료")
          return await send(.appleUserIdDidRevoked)
        case .notFound:
          Log.error("애플 Credential을 찾을 수 없음")
        default:
          break
        }
      } catch: { error, send in
        Log.error(error)
      }
      
    case .appleUserIdDidRevoked:
      authClient.removeAllToken()
      return changeRoot(.Login, state: &state)
      
    default:
      return .none
    }
  }
  
  private func changeRoot(_ root: Root, state: inout State) -> Effect<Action> {
    switch root {
    case .Login:
      state.mainTab = nil
      state.onboarding = nil
      state.login = LoginFeature.State()
      userClient.updateLoginState(isLoggedIn: false)
    case .MainTab:
      state.login = nil
      state.onboarding = nil
      state.mainTab = MainTabViewFeature.State()
    case .Onboarding:
      state.login = nil
      state.mainTab = nil
      state.onboarding = OnboardingFeature.State()
    }
    
    return .none
  }
}
