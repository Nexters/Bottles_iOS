//
//  LocalAuthDataSource.swift
//  DomainAuthInterface
//
//  Created by 임현규 on 7/31/24.
//

import Foundation

public protocol LocalAuthDataSource {
  static func saveToken(token: Token)
  static func loadAccessToken() -> Token
  static func checkTokeinIsExist() -> Bool
}
