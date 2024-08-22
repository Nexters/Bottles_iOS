//
//  AuthClient.swift
//  DomainAuthInterface
//
//  Created by 임현규 on 7/31/24.
//

import Foundation

public struct AuthClient {
  private let signInWithKakao: () async throws -> UserInfo
  private let signInWithApple: () async throws -> UserInfo
  private let saveToken: (Token) -> Void
  private let _checkTokenIsExist: () -> Bool
  private let withdraw: () async throws -> Void
  private let logout: () async throws -> Void
  private let refreshAppleToken: () async throws -> AppleToken
  private let _revokeAppleLogin: () async throws -> Void
  private let fetchAppleClientSecret: () async throws -> String
  private let registerUserProfile: (String) async throws -> Void
  
  public init(
    signInWithKakao: @escaping () async throws -> UserInfo,
    signInWithApple: @escaping () async throws -> UserInfo,
    saveToken: @escaping (Token) -> Void,
    checkTokenIsExist: @escaping () -> Bool,
    withdraw: @escaping () async throws -> Void,
    logout: @escaping () async throws -> Void,
    refreshAppleToken: @escaping () async throws -> AppleToken,
    revokeAppleLogin: @escaping () async throws -> Void,
    fetchAppleClientSecret: @escaping () async throws -> String,
    registerUserProfile: @escaping (String) async throws -> Void
  ) {
    self.signInWithKakao = signInWithKakao
    self.signInWithApple = signInWithApple
    self.saveToken = saveToken
    self._checkTokenIsExist = checkTokenIsExist
    self.logout = logout
    self.withdraw = withdraw
    self.refreshAppleToken = refreshAppleToken
    self._revokeAppleLogin = revokeAppleLogin
    self.fetchAppleClientSecret = fetchAppleClientSecret
    self.registerUserProfile = registerUserProfile
  }
  
  public func signInWithKakao() async throws -> UserInfo {
    try await signInWithKakao()
  }
  
  public func signInWithApple() async throws -> UserInfo {
    try await signInWithApple()
  }
  public func saveToken(token: Token) {
    saveToken(token)
  }
  
  public func checkTokenIsExist() -> Bool {
    return _checkTokenIsExist()
  }
  
  public func withdraw() async throws {
    try await withdraw()
  }
  
  public func logout() async throws {
    try await logout()
  }
  
  public func refreshAppleToken() async throws -> AppleToken {
    return try await refreshAppleToken()
  }
  
  public func revokeAppleLogin() async throws {
    try await _revokeAppleLogin()
  }
  
  public func fetchAppleClientSecret() async throws -> String {
    try await fetchAppleClientSecret()
  }
  
  public func registerUserProfile(userName: String) async throws {
    try await registerUserProfile(userName)
  }
}

