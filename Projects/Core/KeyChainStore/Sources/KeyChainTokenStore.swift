//
//  KeyChainTokenStore.swift
//  CoreKeyChainStore
//
//  Created by 임현규 on 7/31/24.
//

import Foundation

import CoreKeyChainStoreInterface

public struct KeyChainTokenStore: KeyChainStorable {
  public static let shared = KeyChainTokenStore()
  
  public func save(property: TokenStoreProperties, value: String) {
    let query: NSDictionary = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrAccount: property.rawValue,
        kSecValueData: value.data(using: .utf8, allowLossyConversion: false) ?? .init(),
    ]
    SecItemDelete(query)
    SecItemAdd(query, nil)
  }
  
  public func load(property: TokenStoreProperties) -> String {
    let query: NSDictionary = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrAccount: property.rawValue,
        kSecReturnData: kCFBooleanTrue!,
        kSecMatchLimit: kSecMatchLimitOne
    ]
    var dataTypeRef: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
    if status == errSecSuccess {
        guard let data = dataTypeRef as? Data else { return "" }
        return String(data: data, encoding: .utf8) ?? ""
    }
    return ""
  }
  
  public func delete(property: TokenStoreProperties) {
    let query: NSDictionary = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrAccount: property.rawValue
    ]
    SecItemDelete(query)
  }
  
  public func deleteAll() {
    TokenStoreProperties.allCases.forEach { delete(property: $0) }
  }
}
