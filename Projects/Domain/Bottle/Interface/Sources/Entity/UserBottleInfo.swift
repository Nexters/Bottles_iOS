//
//  UserBottleInfo.swift
//  DomainBottleInterface
//
//  Created by 임현규 on 8/13/24.
//

import Foundation

public struct UserBottleInfo {
  public let randomBottleCount: Int
  public let sendBottleCount: Int
  public let nextBottlLeftHours: Int?
  
  public init(
    randomBottleCount: Int,
    sendBottleCount: Int,
    nextBottlLeftHours: Int?
  ) {
    self.randomBottleCount = randomBottleCount
    self.sendBottleCount = sendBottleCount
    self.nextBottlLeftHours = nextBottlLeftHours
  }
}
