//
//  BottleStorageList.swift
//  DomainBottleInterface
//
//  Created by JongHoon on 8/8/24.
//

public struct BottleStorageList: Decodable {
  public let pingPongBottles: [BottleStorageItem]
  
  public init(
    pingPongBottles: [BottleStorageItem]
  ) {
    self.pingPongBottles = pingPongBottles
  }
}

public struct BottleStorageItem: Decodable, Equatable {
  public let age: Int?
  public let id: Int
  public let isRead: Bool
  public let keyword: [String]
  public let mbti: String
  public let userImageUrl: String
  public let userName: String?
  public let lastActivatedAt: String?
  public let lastStatus: PingPongLastStatus?
  
  public init(
    age: Int?,
    id: Int,
    isRead: Bool,
    keyword: [String],
    mbti: String,
    userImageUrl: String,
    userName: String?,
    lastActivatedAt: String?,
    lastStatus: PingPongLastStatus?
  ) {
    self.age = age
    self.id = id
    self.isRead = isRead
    self.keyword = keyword
    self.mbti = mbti
    self.userImageUrl = userImageUrl
    self.userName = userName
    self.lastActivatedAt = lastActivatedAt
    self.lastStatus = lastStatus
  }
}

public enum PingPongLastStatus: String, Decodable {
  /// 대화는 시작했으나 두 사람 모두 문답을 작성하지 않았을 때
  case noAnswerFromBoth = "NO_ANSWER_FROM_BOTH"
  /// 상대방이 새로운 문답을 작성했을 때
  case answerFromOther = "ANSWER_FROM_OTHER"
  /// 상대방이 사진을 공유했을 때
  case photoSharedByOther = "PHOTO_SHARED_BY_OTHER"
  /// 상대방이 연락처를 공유했을 때
  case contactSharedByOther = "CONTACT_SHARED_BY_OTHER"
  /// 내가 문답을 작성했을 때 (상대방은 작성X)
  case answerFromMeOnly = "ANSWER_FROM_ME_ONLY"
  /// 내가 사진을 공유했을 때 (상대방은 공유X)
  case photoSharedByMeOnly = "PHOTO_SHARED_BY_ME_ONLY"
  /// 내가 연락처를 공유했을 때 (상대방은 공유X)
  case contactSharedByMeOnly = "CONTACT_SHARED_BY_ME_ONLY"
  /// 대화가 중단됐을 때
  case conversationStopped = "CONVERSATION_STOPPED"
}
