//
//  AfterProfileResponseDTO.swift
//  DomainAuthInterface
//
//  Created by 임현규 on 9/29/24.
//

import Foundation

public struct AfterProfileResponseDTO: Decodable {
  private let accessToken1: String
  private let accessToken2: String
  private let refreshToken1: String
  private let refreshToken2: String
  
  public func karinaToken() -> Token {
    return .init(
      accessToken: accessToken2,
      refershToken: refreshToken2
    )
  }
  
  public func unWooToken() -> Token {
    return .init(
      accessToken: accessToken1,
      refershToken: refreshToken1
    )
  }
}
