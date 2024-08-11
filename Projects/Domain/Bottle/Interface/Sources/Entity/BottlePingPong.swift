//
//  BottlePingPong.swift
//  DomainBottleInterface
//
//  Created by JongHoon on 8/11/24.
//

import Foundation

public struct BottlePingPong {
  let introduction: [Introduction]?
  let isStopped: Bool
  let letters: [Letter]
  let matchResult: MatchResult
  let photo: Photo
  let stopUserName: String?
  let userProfile: UserProfile
}

struct Introduction: Codable {
  let answer: String
  let question: String
}

struct Letter {
  let canshow: Bool?
  let isDone: Bool
  let myAnswer: String?
  let order: Int?
  let otherAnswer: String?
  let question: String?
  let shouldAnswer: Bool
}

struct MatchResult {
  let isFirstSelect: Bool
  let isMatched: Bool
  let otherContact: String
  let shouldAnswer: Bool
}

struct Photo {
  let isDone: Bool
  let myAnswer: Bool?
  let myImageURL: String?
  let otherAnswer: Bool?
  let otherImageURL: String?
  let shouldAnswer: Bool
}

struct UserProfile {
  let age: Int
  let profileSelect: ProfileSelect?
  let userImageURL: String?
  let userName: String
}

struct ProfileSelect {
  let alcohol: String
  let height: Int
  let interest: Interest
  let job: String
  let keyword: [String]
  let mbti: String
  let region: Region
  let religion: String
  let smoking: String
  
  struct Interest {
    let culture: [String]
    let entertainment: [String]
    let etc: [String]
    let sports: [String]
  }
  
  struct Region {
    let city: String
    let state: String
  }
}
