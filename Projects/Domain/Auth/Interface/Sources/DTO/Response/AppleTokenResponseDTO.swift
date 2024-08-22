//
//  AppleTokenResponseDTO.swift
//  DomainAuthInterface
//
//  Created by 임현규 on 8/21/24.
//

import Foundation

public struct AppleToken {
  public let refreshToken: String
}

public struct AppleTokenResponseDTO: Decodable {
  let accessToken: String?
  let expriesIn: Int?
  let idToken: String?
  let refreshToken: String?
  let tokenType: String?

  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case expriesIn = "expires_in"
    case idToken = "id_token"
    case refreshToken = "refresh_token"
    case tokenType = "token_type"
  }

  public func toDomain() -> AppleToken {
    return .init(refreshToken: refreshToken ?? "")
  }
}
