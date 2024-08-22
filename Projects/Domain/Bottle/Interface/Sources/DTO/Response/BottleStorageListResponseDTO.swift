//
//  BottleStorageListItem.swift
//  DomainBottleInterface
//
//  Created by JongHoon on 8/8/24.
//

import Foundation

// MARK: - Bottle Storage List

public struct BottleStorageListResponseDTO: Decodable {
  let activeBottles: [BottleStorageItemResponseDTO]?
  let doneBottles: [BottleStorageItemResponseDTO]?
  
  public struct BottleStorageItemResponseDTO: Decodable {
    let age: Int?
    let id: Int?
    let isRead: Bool?
    let keyword: [String]?
    let mbti: String?
    let userImageUrl: String?
    let userName: String?
    
    public func toDomain() -> BottleStorageItem {
      return BottleStorageItem(
        age: age ?? -1,
        id: id ?? Int.random(in: Int.min...Int.max),
        isRead: isRead ?? false,
        keyword: keyword ?? [],
        mbti: mbti ?? "",
        userImageUrl: userImageUrl ?? "",
        userName: userName ?? ""
      )
    }
  }
  
  public func toDomain() -> BottleStorageList {
    return BottleStorageList(
      activeBottles: activeBottles?.map { $0.toDomain() } ?? [],
      doneBottles: doneBottles?.map { $0.toDomain() } ?? []
    )
  }
}
