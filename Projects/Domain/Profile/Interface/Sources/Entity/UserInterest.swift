//
//  UserInterest.swift
//  DomainProfileInterface
//
//  Created by 임현규 on 8/2/24.
//

import Foundation

public struct UserInterest {
  public let culture: [String]?
  public let sports: [String]?
  public let entertainment: [String]?
  public let etc: [String]?
  
  public init(
    culture: [String]?,
    sports: [String]?,
    entertainment: [String]?,
    etc: [String]?
  ) {
    self.culture = culture
    self.sports = sports
    self.entertainment = entertainment
    self.etc = etc
  }
}
