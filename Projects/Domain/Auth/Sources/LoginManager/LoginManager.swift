//
//  LoginManager.swift
//  DomainAuth
//
//  Created by 임현규 on 7/31/24.
//

import Foundation
import AuthenticationServices

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
        case .apple:
          return try await signInWithApple()
        case .sms:
          return .init(accessToken: "")
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
  private static func signInWithKakao() async throws -> SignInResult {
    var accessToken = ""
    if UserApi.isKakaoTalkLoginAvailable() {
      accessToken = try await loginWithKakaoTalk()
    } else {
      accessToken = try await loginWithKakaoAccount()
    }
    
    return .init(accessToken: accessToken)
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
        return
      }
    }
  }
}

// MARK: - Apple Login Methods
private extension LoginManager {
  static func signInWithApple() async throws -> SignInResult {
    let appleLoginManager = AppleLoginManager()
    let signInResult = try await appleLoginManager.signInWithApple()
    return signInResult
  }
}

