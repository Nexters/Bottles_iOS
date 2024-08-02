//
//  KeyChainStorable.swift
//  CoreKeyChainStoreInterface
//
//  Created by 임현규 on 7/31/24.
//

import Foundation

public protocol KeyChainStorable {
  func save(property: TokenStoreProperties, value: String)
  func load(property: TokenStoreProperties) -> String
  func delete(property: TokenStoreProperties)
  func deleteAll()
}
