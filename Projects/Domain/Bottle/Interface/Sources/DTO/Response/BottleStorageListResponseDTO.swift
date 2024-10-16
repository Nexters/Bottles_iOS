//
//  BottleStorageListItem.swift
//  DomainBottleInterface
//
//  Created by JongHoon on 8/8/24.
//

import Foundation

// MARK: - Bottle Storage List

public struct BottleStorageListResponseDTO: Decodable {
  let pingPongBottles: [BottleStorageItemResponseDTO]?
  
  public struct BottleStorageItemResponseDTO: Decodable {
    let age: Int?
    let id: Int?
    let isRead: Bool?
    let keyword: [String]?
    let mbti: String?
    let userImageUrl: String?
    let userName: String?
    let lastActivatedAt: String?
    let lastStatus: String?
    
    public func toDomain() -> BottleStorageItem {
      return BottleStorageItem(
        age: age ?? -1,
        id: id ?? Int.random(in: Int.min...Int.max),
        isRead: isRead ?? false,
        keyword: keyword ?? [],
        mbti: mbti ?? "",
        userImageUrl: userImageUrl ?? "",
        userName: userName ?? "",
        lastActivatedAt: lastActivatedAt ?? "",
        lastStatus: PingPongLastStatus(rawValue: lastStatus ?? "")
      )
    }
  }
  
  public func toDomain() -> BottleStorageList {
    return BottleStorageList(
      pingPongBottles: pingPongBottles?.map { $0.toDomain() } ?? [])
  }
}
