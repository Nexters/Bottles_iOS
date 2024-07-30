//
//  BottleListResponseDTO.swift
//  DomainBottle
//
//  Created by 임현규 on 7/29/24.
//

import Foundation

// MARK: - BottleList
public struct BottleListResponseDTO: Decodable {
  public let bottles: [BottleItemDTO]?
  
  // MARK: - BottleItem
  public struct BottleItemDTO: Codable {
    let age: Int?
    let expiredAt: String?
    let id: Int?
    let keyword: [String]?
    let mbti: String?
    let userName: String?
  }
}

