//
//  BottlePingPong.swift
//  DomainBottleInterface
//
//  Created by JongHoon on 8/11/24.
//

import Foundation

public struct BottlePingPong: Equatable {
  public let introduction: [QuestionAndAnswer]?
  public let isStopped: Bool
  public let letters: [Letter]
  public let matchResult: MatchResult
  public let photo: Photo
  public let stopUserName: String?
  public let userProfile: UserProfile
  
  public init(
    introduction: [QuestionAndAnswer]? = nil,
    isStopped: Bool,
    letters: [Letter],
    matchResult: MatchResult,
    photo: Photo,
    stopUserName: String? = nil,
    userProfile: UserProfile
  ) {
    self.introduction = introduction
    self.isStopped = isStopped
    self.letters = letters
    self.matchResult = matchResult
    self.photo = photo
    self.stopUserName = stopUserName
    self.userProfile = userProfile
  }
}

public struct QuestionAndAnswer: Codable, Equatable {
  public let answer: String
  public let question: String
  
  public init(
    answer: String,
    question: String
  ) {
    self.answer = answer
    self.question = question
  }
}

public struct Letter: Equatable {
  public let canshow: Bool?
  public let isDone: Bool
  public let myAnswer: String?
  public let order: Int?
  public let otherAnswer: String?
  public let question: String?
  public let shouldAnswer: Bool
  
  public init(
    canshow: Bool? = nil,
    isDone: Bool,
    myAnswer: String? = nil,
    order: Int? = nil,
    otherAnswer: String? = nil,
    question: String? = nil,
    shouldAnswer: Bool
  ) {
    self.canshow = canshow
    self.isDone = isDone
    self.myAnswer = myAnswer
    self.order = order
    self.otherAnswer = otherAnswer
    self.question = question
    self.shouldAnswer = shouldAnswer
  }
}

public struct MatchResult: Equatable {
  public let isFirstSelect: Bool
  public let matchStatus: BottleMatchStatus
  public let otherContact: String
  public let shouldAnswer: Bool
  
  init(
    isFirstSelect: Bool,
    matchStatus: BottleMatchStatus,
    otherContact: String,
    shouldAnswer: Bool
  ) {
    self.isFirstSelect = isFirstSelect
    self.matchStatus = matchStatus
    self.otherContact = otherContact
    self.shouldAnswer = shouldAnswer
  }
}

public enum BottleMatchStatus {
  case inConversation
  case matchFailed
  case matchSucceeded
}

public struct Photo: Equatable {
  public let isDone: Bool
  public let myAnswer: Bool?
  public let myImageURL: String?
  public let otherAnswer: Bool?
  public let otherImageURL: String?
  public let shouldAnswer: Bool
  
  init(
    isDone: Bool,
    myAnswer: Bool? = nil,
    myImageURL: String? = nil,
    otherAnswer: Bool? = nil,
    otherImageURL: String? = nil,
    shouldAnswer: Bool
  ) {
    self.isDone = isDone
    self.myAnswer = myAnswer
    self.myImageURL = myImageURL
    self.otherAnswer = otherAnswer
    self.otherImageURL = otherImageURL
    self.shouldAnswer = shouldAnswer
  }
}

public struct UserProfile: Equatable {
  public let userId: Int
  public let age: Int
  public let profileSelect: ProfileSelect?
  public let userImageURL: String?
  public let userName: String
  
  public init(
    userId: Int,
    age: Int,
    profileSelect: ProfileSelect? = nil,
    userImageURL: String? = nil,
    userName: String
  ) {
    self.userId = userId
    self.age = age
    self.profileSelect = profileSelect
    self.userImageURL = userImageURL
    self.userName = userName
  }
}

public struct ProfileSelect: Equatable {
  public static func == (lhs: ProfileSelect, rhs: ProfileSelect) -> Bool {
    return lhs.id == rhs.id
  }
  
  public let id: UUID
  public let alcohol: String
  public let height: Int
  public let interest: Interest
  public let job: String
  public let keyword: [String]
  public let mbti: String
  public let region: Region
  public let religion: String
  public let smoking: String
  
  public init(
    alcohol: String,
    height: Int,
    interest: Interest, 
    job: String,
    keyword: [String],
    mbti: String, 
    region: Region,
    religion: String,
    smoking: String
  ) {
    self.id = UUID()
    self.alcohol = alcohol
    self.height = height
    self.interest = interest
    self.job = job
    self.keyword = keyword
    self.mbti = mbti
    self.region = region
    self.religion = religion
    self.smoking = smoking
  }
}

public struct Interest: Equatable {
  public let culture: [String]
  public let entertainment: [String]
  public let etc: [String]
  public let sports: [String]
  
  public init(
    culture: [String],
    entertainment: [String],
    etc: [String],
    sports: [String]
  ) {
    self.culture = culture
    self.entertainment = entertainment
    self.etc = etc
    self.sports = sports
  }
}

public struct Region: Equatable {
  public let city: String
  public let state: String
  
  public init(
    city: String,
    state: String
  ) {
    self.city = city
    self.state = state
  }
}
