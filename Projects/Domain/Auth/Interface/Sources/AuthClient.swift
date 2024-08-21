//
//  AuthClient.swift
//  DomainAuthInterface
//
//  Created by 임현규 on 7/31/24.
//

import Foundation

public struct AuthClient {
  private let signInWithKakao: () async throws -> SignInResponseDTO
  private let signInWithApple: () async throws -> SignInResponseDTO
  private let saveToken: (Token) -> Void
  private let _checkTokenIsExist: () -> Bool
  private let withdraw: () async throws -> Void
  private let logout: () async throws -> Void
  private let refreshAppleToken: () async throws -> AppleToken
  private let _revokeAppleLogin: () async throws -> Void
  private let fetchAppleClientSecret: () async throws -> String
  
  public init(
    signInWithKakao: @escaping () async throws -> SignInResponseDTO,
    signInWithApple: @escaping () async throws -> SignInResponseDTO,
    saveToken: @escaping (Token) -> Void,
    checkTokenIsExist: @escaping () -> Bool,
    logout: @escaping () async throws -> Void,
    withdraw: @escaping () async throws -> Void,
    refreshAppleToken: @escaping () async throws -> AppleToken,
    revokeAppleLogin: @escaping () async throws -> Void,
    fetchAppleClientSecret: @escaping () async throws -> String
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
  }
  
  public func signInWithKakao() async throws -> SignInResponseDTO {
    try await signInWithKakao()
  }
  
  public func signInWithApple() async throws -> SignInResponseDTO {
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
}

