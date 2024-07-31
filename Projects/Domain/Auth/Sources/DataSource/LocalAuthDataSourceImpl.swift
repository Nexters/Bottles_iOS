//
//  LocalAuthDataSourceImpl.swift
//  DomainAuth
//
//  Created by 임현규 on 7/31/24.
//

import DomainAuthInterface

import CoreKeyChainStore

struct LocalAuthDataSourceImpl: LocalAuthDataSource {
  static func saveToken(token: Token) {
    KeyChainTokenStore.shared.save(property: .accessToken, value: token.accessToken)
    KeyChainTokenStore.shared.save(property: .refreshToken, value: token.refershToken)
  }
  
  static func loadAccessToken() -> Token {
    return Token(
      accessToken: KeyChainTokenStore.shared.load(property: .accessToken),
      refershToken: KeyChainTokenStore.shared.load(property: .refreshToken)
      )
  }
  
  static func checkTokeinIsExist() -> Bool {
    return !KeyChainTokenStore.shared.load(property: .accessToken).isEmpty
  }
}
