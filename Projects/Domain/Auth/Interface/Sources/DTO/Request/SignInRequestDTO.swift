//
//  SignInRequestDTO.swift
//  DomainAuth
//
//  Created by 임현규 on 7/31/24.
//

import Foundation

public struct SignInRequestDTO: Encodable {
  public let code: String
  public let fcmDeviceToken: String
  
  public init(
    code: String,
    fcmDeviceToken: String
  ) {
    self.code = code
    self.fcmDeviceToken = fcmDeviceToken
  }
}
