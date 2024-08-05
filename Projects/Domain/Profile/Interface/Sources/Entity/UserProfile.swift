//
//  UserProfile.swift
//  DomainProfileInterface
//
//  Created by 임현규 on 8/2/24.
//

import Foundation

public struct UserProfile {
  public let mbti: String
  public let keyword: [String]
  public let interset: UserInterest
  public let job: String
  public let smoke: String
  public let alcohol: String
  public let height: Int
  public let region: UserRegion
  
  public init(
    mbti: String,
    keyword: [String],
    interset: UserInterest,
    job: String,
    smoke: String,
    alcohol: String,
    height: Int,
    region: UserRegion
  ) {
    self.mbti = mbti
    self.keyword = keyword
    self.interset = interset
    self.job = job
    self.smoke = smoke
    self.alcohol = alcohol
    self.height = height
    self.region = region
  }
}

