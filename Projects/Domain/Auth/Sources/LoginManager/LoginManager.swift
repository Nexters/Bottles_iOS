//
//  LoginManager.swift
//  DomainAuth
//
//  Created by 임현규 on 7/31/24.
//

import Foundation

import CoreLoggerInterface

import KakaoSDKUser

struct LoginManager {
  enum LoginType {
    case kakao
    case sms
  }
  
  /// 로그인 타입에 따라 Provider로 부터 받은 AuthToken & AccessToken을 반환합니다.
  /// - Parameters:
  ///   - loginType: 로그인하는 Type
  func signIn(loginType: LoginType) async throws -> String {
    switch loginType {
    case .kakao:
      return try await signInWithKakao()
    case .sms:
      // TODO: - SMS 로그인 구현
      return ""
    }
  }
}

// MARK: - Kakao SignIn Methods
private extension LoginManager {
  @MainActor
  func signInWithKakao() async throws -> String {
    var accessToken = ""
    if UserApi.isKakaoTalkLoginAvailable() {
      accessToken = try await loginWithKakaoTalk()
    } else {
      accessToken = try await loginWithKakaoAccount()
    }
    
    return accessToken
  }
  
  @MainActor
  func loginWithKakaoTalk() async throws -> String {
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
  func loginWithKakaoAccount() async throws -> String {
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
