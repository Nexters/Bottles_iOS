//
//  TokenStoreProperties.swift
//  CoreKeyChainStoreInterface
//
//  Created by 임현규 on 7/31/24.
//

import Foundation

public enum TokenStoreProperties: String, CaseIterable {
  case accessToken = "ACCESS-TOKEN"
  case refreshToken = "REFRESH-TOKEN"
  case AppleUserID = "APPLE-USER-ID"
  case AppleRefreshToken = "APPLE-REFRESH-TOKEN"
  case AppleClientSecret = "APPLE-CLIENT-SECRET"
  case AppleAuthCode = "APPLE-AUTH-CODE"
}
