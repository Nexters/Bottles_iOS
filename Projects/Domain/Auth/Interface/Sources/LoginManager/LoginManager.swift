//
//  LoginManager.swift
//  DomainAuth
//
//  Created by 임현규 on 8/2/24.
//

import Foundation

import DomainAuthInterface
import CoreLoggerInterface

import KakaoSDKUser
import ComposableArchitecture

extension LoginManager: DependencyKey {
  static public let liveValue: LoginManager = .live()
  
  static public func live() -> Self {
    return .init(
      signIn: { loginType in
        switch loginType {
        case .kakao:
          return try await signInWithKakao()
        case .sms:
          return ""
        }
      }
    )
  }
}

extension DependencyValues {
  public var loginManager: LoginManager {
    get { self[LoginManager.self] }
    set { self[LoginManager.self] = newValue }
  }
}

// MARK: - Kakao SignIn Methods
extension LoginManager {  
  @MainActor
  private static func signInWithKakao() async throws -> String {
    var accessToken = ""
    if UserApi.isKakaoTalkLoginAvailable() {
      accessToken = try await loginWithKakaoTalk()
    } else {
      accessToken = try await loginWithKakaoAccount()
    }
    
    return accessToken
  }
  
  @MainActor
  private static func loginWithKakaoTalk() async throws -> String {
    return try await withCheckedThrowingContinuation { continuation in
      UserApi.shared.loginWithKakaoTalk { oauthToken, error in
        if let error = error {
          Log.error(error)
          continuation.resume(throwing: error)
        } else if let token = oauthToken?.accessToken {
          Log.debug("Received accessToken: \(token)")
          continuation.resume(returning: token)
        } else {
          continuation.resume(throwing: URLError(.badServerResponse))
          Log.error("Kakao Login Error")
        }
      }
    }
  }
  
  @MainActor
  private static func loginWithKakaoAccount() async throws -> String {
    return try await withCheckedThrowingContinuation { continuation in
      UserApi.shared.loginWithKakaoAccount { oauthToken, error in
        if let error = error {
          Log.error(error)
          continuation.resume(throwing: error)
        } else if let token = oauthToken?.accessToken {
          Log.debug("Received accessToken: \(token)")
          continuation.resume(returning: token)
        } else {
          continuation.resume(throwing: URLError(.badServerResponse))
          Log.error("Kakao Login Error")
        }
      }
    }
  }
}

