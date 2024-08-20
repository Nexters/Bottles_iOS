//
//  LoginFeature.swift
//  FeatureLogin
//
//  Created by JongHoon on 7/25/24.
//

import Foundation

import DomainAuth
import DomainAuthInterface
import CoreLoggerInterface
import FeatureOnboardingInterface
import FeatureGeneralSignUpInterface

import ComposableArchitecture

extension LoginFeature {
  public init() {
    @Dependency(\.authClient) var authClient
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
        
      case .signInKakaoButtonDidTapped:
        return .run { send in
          let userInfo = try await authClient.signInWithKakao().toDomain()
          await send(.socialLoginDidSuccess(userInfo))
        } catch: { error, send in
          await send(.goToGeneralLogin)
        }
        
      case .signInGeneralButtonDidTapped:
        state.path.append(.generalLogin(.init()))
        return .none
        
      case .signInAppleButtonDidTapped:
        return .run { send in
          let userInfo = try await authClient.signInWithApple().toDomain()
          await send(.socialLoginDidSuccess(userInfo))
        } catch: { error, send in
          // TODO: apple Login error
          await send(.goToGeneralLogin)
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
          
      case .goToGeneralLogin:
        // TODO: - 일반 로그인 화면으로 이동.
        return .none
        
      case let .signUpCheckCompleted(isSignUp):
        if isSignUp {
          return .send(.goToMainTab)
        } else {
          return goToOboarding(state: &state)
        }
        
      case .path(.element(id: _, action: .onBoarding(.delegate(.createOnboardingProfileDidCompleted)))):
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
        
      default:
        return .none
      }
      
      // MARK: - Inner Methods
      
      func goToOboarding(state: inout LoginFeature.State) -> Effect<Action> {
        state.path.append(.onBoarding(.init()))
        return .none
      }
      
      func handleLoginSuccessUserInfo(state: inout State, userInfo: UserInfo) -> Effect<Action> {
        let token = userInfo.token, isSignUp = userInfo.isSignUp
        let isCompletedOnboardingIntroduction = userInfo.isCompletedOnboardingIntroduction
        authClient.saveToken(token: token)
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
  }
  
  // MARK: - Destination
  
  @Reducer(state: .equatable)
  public enum Destination {
    case termsView
  }
}
