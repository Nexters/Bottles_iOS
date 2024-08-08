//
//  LoginFeature.swift
//  FeatureLogin
//
//  Created by JongHoon on 7/25/24.
//

import Foundation

import DomainAuth
import CoreLoggerInterface
import FeatureOnboardingInterface

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
          await send(.signInKakaoDidSuccess(userInfo))
        } catch: { error, send in
          await send(.goToGeneralLogin)
        }
        
      case let .signInKakaoDidSuccess(userInfo):
        let token = userInfo.token, isSignUp = userInfo.isSignUp
        let isCompletedOnboardingIntroduction = userInfo.isCompletedOnboardingIntroduction
        authClient.saveToken(token: token)
        if isSignUp && !isCompletedOnboardingIntroduction {
          return moveToOboarding(state: &state)
        }
        return .send(.signUpCheckCompleted(isSignUp: isSignUp))
          
      case .goToGeneralLogin:
        // TODO: - 일반 로그인 화면으로 이동.
        return .none
        
      case let .signUpCheckCompleted(isSignUp):
        if !isSignUp {
          return .send(.goToMainTab, animation: .default)
        } else {
          return moveToOboarding(state: &state)
        }
        
      case .path(.element(id: _, action: .onBoarding(.delegate(.createOnboardingProfileDidCompleted)))):
        return .send(.delegate(.createOnboardingProfileDidCompleted))
        
      default:
        return .none
      }
      
      func moveToOboarding(state: inout LoginFeature.State) -> Effect<Action> {
        state.path.append(.onBoarding(.init()))
        return .none
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
    case onBoarding(OnboardingFeature)
  }
}
