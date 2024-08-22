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
  public var userName: String?
  
  public init(
    token: Token,
    isSignUp: Bool,
    isCompletedOnboardingIntroduction: Bool,
    userName: String? = nil
  ) {
    self.token = token
    self.isSignUp = isSignUp
    self.isCompletedOnboardingIntroduction = isCompletedOnboardingIntroduction
    self.userName = userName
  }
}

public struct SignInResponseDTO: Decodable {
  public let accessToken: String
  public let refreshToken: String
  public let isSignUp: Bool
  public let hasCompleteUserProfile: Bool
  
  public func toDomain() -> UserInfo {
    return UserInfo(
      token: Token(
        accessToken: accessToken,
        refershToken: refreshToken),
      // 서버에서 회원 가입 시 isSignUp: false로 내려 줌
      isSignUp: !isSignUp,
      isCompletedOnboardingIntroduction: hasCompleteUserProfile
    )
  }
}
