//
//  LoginFeature.swift
//  FeatureLogin
//
//  Created by JongHoon on 7/25/24.
//

import Foundation

import FeatureOnboardingInterface
import FeatureGeneralSignUpInterface
import FeatureGuideInterface

import DomainAuth
import DomainAuthInterface
import DomainUser

import CoreLoggerInterface
import CoreKeyChainStore

import ComposableArchitecture

extension LoginFeature {
  public init() {
    @Dependency(\.authClient) var authClient
    @Dependency(\.userClient) var userClient
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
        
      case .signInKakaoButtonDidTapped:
        return .run { send in
          let userInfo = try await authClient.signInWithKakao()
          await send(.socialLoginDidSuccess(userInfo))
        } catch: { error, send in
          await send(.goToGeneralLogin)
        }
        
      case .signInGeneralButtonDidTapped:
        state.path.append(.generalLogin(.init()))
        return .none
        
      case .signInAppleButtonDidTapped:
        return .run { send in
          await send(.indicatorStateChanged(isLoading: true))
          let userInfo = try await authClient.signInWithApple()
          await send(.socialLoginDidSuccess(userInfo))
          // clientSceret 받아오기
          
          let clientSceret = try await authClient.fetchAppleClientSecret()
          KeyChainTokenStore.shared.save(property: .AppleClientSecret, value: clientSceret)
          
          // refresh 토큰 받아오기
          let appleToken = try await authClient.refreshAppleToken()
          let appleRefreshToken = appleToken.refreshToken
          KeyChainTokenStore.shared.save(property: .AppleRefreshToken, value: appleRefreshToken)
          await send(.indicatorStateChanged(isLoading: false))
        } catch: { error, send in
          // TODO: apple Login error
          Log.error(error.localizedDescription)
          await send(.indicatorStateChanged(isLoading: false))
        }
        
      case .personalInformationTermButtonDidTapped:
        state.termURL = "https://spiral-ogre-a4d.notion.site/abb2fd284516408e8c2fc267d07c6421"
        state.isPresentTermView = true
        return .none
        
      case .utilizationTermButtonDidTapped:
        state.termURL = "https://spiral-ogre-a4d.notion.site/240724-e3676639ea864147bb293cfcda40d99f"
        state.isPresentTermView = true
        return .none
        
      case let .socialLoginDidSuccess(userInfo):
        return handleLoginSuccessUserInfo(state: &state, userInfo: userInfo)
        
      case let .indicatorStateChanged(isLoading):
        state.isLoading = isLoading
        return .none
        
      case let .userProfileFetchRequired(userName):
        return .run { send in
          try await authClient.registerUserProfile(userName: userName)
          await send(.userProfileFetchDiduccess)
        }
        
      case .userProfileFetchDiduccess:
        return .send(.signUpCheckCompleted(isSignUp: false))
        
      case .goToGeneralLogin:
        // TODO: - 일반 로그인 화면으로 이동.
        return .none
        
      case let .signUpCheckCompleted(isSignUp):
        if isSignUp {
          return .send(.goToMainTab)
        } else {
          return goToGuide(state: &state)
        }
        
      case .guideDidCompleted:
        return goToOboarding(state: &state)

      case .snsLoginButtonDidTapped:
        state.path.append(.appleLogin(AppleLoginFeature.State()))
        return .none
        
      case .path(.element(id: _, action: .onBoarding(.delegate(.createOnboardingProfileDidCompleted)))):
        state.path.removeAll()
        return .send(.delegate(.createOnboardingProfileDidCompleted))
        
      case let .path(.element(id: _, action: .generalLogin(.delegate(delegate)))):
        switch delegate {
        case let .generalLogInDidSucess(userInfo):
          return handleLoginSuccessUserInfo(state: &state, userInfo: userInfo)
        }
        
      case let .path(.element(id: _, action: .generalSignUp(.delegate(delegate)))):
        switch delegate {
        case let .signUpDidCompleted(userInfo):
          return handleLoginSuccessUserInfo(state: &state, userInfo: userInfo)
        }
        
      // MainGuide Delegate
      case let .path(.element(id: _, action: .mainGuide(.delegate(delegate)))):
        switch delegate {
        case .nextButtonDidTapped:
          state.path.append(.pingPongGuide(.init()))
          return .none
        }
        
      // PingPongGuide Delegate
      case let .path(.element(id: _, action: .pingPongGuide(.delegate(delegate)))):
        switch delegate {
        case .nextButtonDidTapped:
          state.path.append(.photoShareGuide(.init()))
          return .none
        }
        // PhotoShareGuide Delegate
        
      case let .path(.element(id: _, action: .photoShareGuide(.delegate(delegate)))):
        switch delegate {
        case .nextButtonDidTapped:
          state.path.append(.startGuide(.init()))
          return .none
        }
        // StartGuide Delegate
      case let .path(.element(id: _, action: .startGuide(.delegate(delegate)))):
        switch delegate {
        case .doneButtonDidTapped:
          return goToOboarding(state: &state) 
        }
      // appleLogin Delegate
    
      case let .path(.element(id: _, action: .appleLogin(.delegate(delegate)))):
        switch delegate {
        case .signInAppleButtonDidTapped:
          return .send(.signInAppleButtonDidTapped)
        }
      default:
        return .none
      }
      
      // MARK: - Inner Methods
      func goToGuide(state: inout LoginFeature.State) -> Effect<Action> {
        state.path.append(.mainGuide(.init()))
        return .none
      }
      
      func goToOboarding(state: inout LoginFeature.State) -> Effect<Action> {
        state.path.append(.onBoarding(.init()))
        return .none
      }
      
      func handleLoginSuccessUserInfo(state: inout State, userInfo: UserInfo) -> Effect<Action> {
        let token = userInfo.token, isSignUp = userInfo.isSignUp
        let isCompletedOnboardingIntroduction = userInfo.isCompletedOnboardingIntroduction
        authClient.saveToken(token: token)
        userClient.updateLoginState(isLoggedIn: true)
        
        Log.error(token)
        
        state.path.removeAll()
        if let userName = userInfo.userName, !isSignUp {
          return .send(.userProfileFetchRequired(userName: userName))
        }
        
        if isSignUp && !isCompletedOnboardingIntroduction {
          return goToOboarding(state: &state)
        }
        return .send(.signUpCheckCompleted(isSignUp: isSignUp))
      }
    }
    self.init(reducer: reducer)
  }
}

extension LoginFeature {
  // MARK: - Path
  
  @Reducer(state: .equatable)
  public enum Path {
    case generalLogin(GeneralLogInFeature)
    case generalSignUp(GeneralSignUpFeature)
    case onBoarding(OnboardingFeature)
    case mainGuide(MainGuideFeature)
    case pingPongGuide(PingPongGuideFeature)
    case photoShareGuide(PhotoShareGuideFeature)
    case startGuide(StartGuideFeature)
    case appleLogin(AppleLoginFeature)
  }
  
  // MARK: - Destination
  
  @Reducer(state: .equatable)
  public enum Destination {
    case termsView
  }
}
