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
      case .signInKakaoRequest:
        return .run { send in
          await send(.signInKakaoResponse(
            TaskResult {
              try await authClient.signInWithKakao().toDomain()
            }
          ))
        }
      case let .signInKakaoResponse(.success(userInfo)):
        let token = userInfo.token
        Log.debug(token)
        authClient.saveToken(token: token)
        let isSignUp = userInfo.isSignUp
        return .send(.signUpCheckCompleted(isSignUp: isSignUp))
      case let .signInKakaoResponse(.failure(error)):
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

