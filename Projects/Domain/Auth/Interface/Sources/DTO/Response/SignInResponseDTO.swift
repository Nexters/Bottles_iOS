//
//  SignInResponseDTO.swift
//  DomainAuth
//
//  Created by 임현규 on 7/31/24.
//

import Foundation

public struct SignInResponseDTO: Decodable {
  public let accessToken: String?
  public let isSignUp: Bool?
  public let refreshToken: String?
  
  public func toDomain() -> Token {
    return Token(
      accessToken: accessToken ?? "",
      refershToken: refreshToken ?? ""
    )
  }
}
