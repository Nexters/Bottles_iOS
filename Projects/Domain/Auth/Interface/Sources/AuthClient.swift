//
//  AuthClient.swift
//  DomainAuthInterface
//
//  Created by 임현규 on 7/31/24.
//

import Foundation

public struct AuthClient {
  private var signInWithKakao: () async throws -> SignInResponseDTO
  private var saveToken: (Token) -> Void
  private var _checkTokenIsExist: () -> Bool
  
  public init(
    signInWithKakao: @escaping () async throws -> SignInResponseDTO,
    saveToken: @escaping (Token) -> Void,
    checkTokenIsExist: @escaping () -> Bool
  ) {
    self.signInWithKakao = signInWithKakao
    self.saveToken = saveToken
    self._checkTokenIsExist = checkTokenIsExist
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
}

