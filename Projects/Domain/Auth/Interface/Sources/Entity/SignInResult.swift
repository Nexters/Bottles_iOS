//
//  SignInResult.swift
//  DomainAuth
//
//  Created by 임현규 on 8/21/24.
//

import Foundation

public struct SignInResult {
  public let accessToken: String
  public let userName: String?
  
  public init(accessToken: String, userName: String? = nil) {
    self.accessToken = accessToken
    self.userName = userName
  }
}
