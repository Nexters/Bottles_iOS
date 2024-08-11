//
//  BottlePingPong.swift
//  DomainBottleInterface
//
//  Created by JongHoon on 8/11/24.
//

import Foundation

public struct BottlePingPong {
  public let introduction: [Introduction]?
  public let isStopped: Bool
  public let letters: [Letter]
  public let matchResult: MatchResult
  public let photo: Photo
  public let stopUserName: String?
  public let userProfile: UserProfile
  
  public init(
    introduction: [Introduction]? = nil,
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

public struct Introduction: Codable {
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

public struct Letter {
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

public struct MatchResult {
  public let isFirstSelect: Bool
  public let isMatched: Bool
  public let otherContact: String
  public let shouldAnswer: Bool
  
  init(
    isFirstSelect: Bool,
    isMatched: Bool,
    otherContact: String,
    shouldAnswer: Bool
  ) {
    self.isFirstSelect = isFirstSelect
    self.isMatched = isMatched
    self.otherContact = otherContact
    self.shouldAnswer = shouldAnswer
  }
}

public struct Photo {
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

public struct UserProfile {
  public let age: Int
  public let profileSelect: ProfileSelect?
  public let userImageURL: String?
  public let userName: String
  
  public init(
    age: Int,
    profileSelect: ProfileSelect? = nil,
    userImageURL: String? = nil,
    userName: String
  ) {
    self.age = age
    self.profileSelect = profileSelect
    self.userImageURL = userImageURL
    self.userName = userName
  }
}

public struct ProfileSelect {
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

public struct Interest {
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

public struct Region {
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
