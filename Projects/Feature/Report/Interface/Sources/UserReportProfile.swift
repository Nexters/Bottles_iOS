//
//  UserReportProfile.swift
//  FeatureReportInterface
//
//  Created by 임현규 on 8/12/24.
//

import Foundation

public struct UserReportProfile: Equatable {
  var imageURL: String
  var userID: Int
  var userName: String
  var userAge: Int
  
  public init(
    imageURL: String,
    userID: Int,
    userName: String,
    userAge: Int
  ) {
    self.imageURL = imageURL
    self.userID = userID
    self.userName = userName
    self.userAge = userAge
  }
}
