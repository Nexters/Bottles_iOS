//
//  SignInResponseDTO.swift
//  DomainAuth
//
//  Created by 임현규 on 7/31/24.
//

import Foundation

public struct UserInfo {
  public let token: Token
  public let isSignUp: Bool
  
  init(token: Token, isSignUp: Bool) {
    self.token = token
    self.isSignUp = isSignUp
  }
}
public struct SignInResponseDTO: Decodable {
  public let accessToken: String
  public let refreshToken: String
  public let isSignUp: Bool
  
  public func toDomain() -> UserInfo {
    return UserInfo(
      token: Token(
        accessToken: accessToken,
        refershToken: refreshToken),
      isSignUp: isSignUp
    )
  }
}
