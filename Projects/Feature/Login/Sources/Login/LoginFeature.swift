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
      case let .signInKakaoResponse(.success(token)):
        authClient.saveToken(token: token)
        return .none
      // TODO: - SNS 로그인화면으로 이동.
      // 카카오 로그인 취소하면 해당 Action으로 옴
      case let .signInKakaoResponse(.failure(error)):
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}

