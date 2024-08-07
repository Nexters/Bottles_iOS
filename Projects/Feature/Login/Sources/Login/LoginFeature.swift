//
//  LoginFeature.swift
//  FeatureLogin
//
//  Created by JongHoon on 7/25/24.
//

import Foundation

import FeatureLoginInterface
import CoreNetwork
import DomainAuth
import CoreLoggerInterface

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
        authClient.saveToken(token: token)
        return .send(.signUpCheckCompleted(isSignUp: isSignUp))
        
      case .goToGeneralLogin:
        // TODO: - 일반 로그인 화면으로 이동.
        return .none
        
      case let .signUpCheckCompleted(isSignUp):
        if !isSignUp {
          return .send(.goToMainTab)
        } else {
          // TODO: OnboardingView로 이동
          Log.debug(isSignUp)
          return .none
        }
        
      default:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}

