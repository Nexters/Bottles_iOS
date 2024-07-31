//
//  TokenEntity.swift
//  DomainAuthInterface
//
//  Created by 임현규 on 7/31/24.
//

import Foundation

public struct Token: Equatable {
  public init(
    accessToken: String,
    refershToken: String
  ) {
    self.accessToken = accessToken
    self.refershToken = refershToken
  }
  
  public let accessToken: String
  public let refershToken: String
}
