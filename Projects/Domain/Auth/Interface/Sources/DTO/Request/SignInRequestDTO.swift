//
//  SignInRequestDTO.swift
//  DomainAuth
//
//  Created by 임현규 on 7/31/24.
//

import Foundation

public struct SignInRequestDTO: Encodable {
  public let code: String
  
  public init(code: String) {
    self.code = code
  }
}
