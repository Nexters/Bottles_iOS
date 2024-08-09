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
  public let isCompletedOnboardingIntroduction: Bool
  
  init(
    token: Token,
    isSignUp: Bool,
    isCompletedOnboardingIntroduction: Bool
  ) {
    self.token = token
    self.isSignUp = isSignUp
    self.isCompletedOnboardingIntroduction = isCompletedOnboardingIntroduction
  }
}
public struct SignInResponseDTO: Decodable {
  public let accessToken: String
  public let refreshToken: String
  public let isSignUp: Bool
  public let hasCompleteIntroduction: Bool
  
  public func toDomain() -> UserInfo {
    return UserInfo(
      token: Token(
        accessToken: accessToken,
        refershToken: refreshToken),
      isSignUp: isSignUp, 
      isCompletedOnboardingIntroduction: hasCompleteIntroduction
    )
  }
}
