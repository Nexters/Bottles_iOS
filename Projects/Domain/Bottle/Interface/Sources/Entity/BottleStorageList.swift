//
//  BottleStorageList.swift
//  DomainBottleInterface
//
//  Created by JongHoon on 8/8/24.
//

public struct BottleStorageList: Decodable {
  let activeBottles: [BottleStorageItem]
  let doneBottles: [BottleStorageItem]
  
  public init(
    activeBottles: [BottleStorageItem],
    doneBottles: [BottleStorageItem]
  ) {
    self.activeBottles = activeBottles
    self.doneBottles = doneBottles
  }
  
}

public struct BottleStorageItem: Decodable {
  let age: Int?
  let id: Int?
  let isRead: Bool?
  let keyword: [String]
  let mbti: String
  let userImageUrl: String
  let userName: String?
}
