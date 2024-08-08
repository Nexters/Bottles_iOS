//
//  BottleStorageList.swift
//  DomainBottleInterface
//
//  Created by JongHoon on 8/8/24.
//

public struct BottleStorageList: Decodable {
  public let activeBottles: [BottleStorageItem]
  public let doneBottles: [BottleStorageItem]
  
  public init(
    activeBottles: [BottleStorageItem],
    doneBottles: [BottleStorageItem]
  ) {
    self.activeBottles = activeBottles
    self.doneBottles = doneBottles
  }
  
}

public struct BottleStorageItem: Decodable, Equatable {
  public let age: Int?
  public let id: Int
  public let isRead: Bool?
  public let keyword: [String]
  public let mbti: String
  public let userImageUrl: String
  public let userName: String?
  
  public init(
    age: Int?,
    id: Int,
    isRead: Bool?,
    keyword: [String],
    mbti: String,
    userImageUrl: String,
    userName: String?
  ) {
    self.age = age
    self.id = id
    self.isRead = isRead
    self.keyword = keyword
    self.mbti = mbti
    self.userImageUrl = userImageUrl
    self.userName = userName
  }
}
