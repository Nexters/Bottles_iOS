//
//  AuthClient.swift
//  DomainAuthInterface
//
//  Created by 임현규 on 7/31/24.
//

import Foundation

public struct AuthClient {
  private let signInWithKakao: () async throws -> SignInResponseDTO
  private let saveToken: (Token) -> Void
  private let _checkTokenIsExist: () -> Bool
  private let withdraw: () async throws -> Void
  private let logout: () async throws -> Void
  
  public init(
    signInWithKakao: @escaping () async throws -> SignInResponseDTO,
    saveToken: @escaping (Token) -> Void,
    checkTokenIsExist: @escaping () -> Bool,
    logout: @escaping () async throws -> Void,
    withdraw: @escaping () async throws -> Void
  ) {
    self.signInWithKakao = signInWithKakao
    self.saveToken = saveToken
    self._checkTokenIsExist = checkTokenIsExist
    self.logout = logout
    self.withdraw = withdraw
  }
  
  public func signInWithKakao() async throws -> SignInResponseDTO {
    try await signInWithKakao()
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
}

