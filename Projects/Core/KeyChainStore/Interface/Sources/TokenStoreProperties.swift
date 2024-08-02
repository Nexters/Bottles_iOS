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
}
