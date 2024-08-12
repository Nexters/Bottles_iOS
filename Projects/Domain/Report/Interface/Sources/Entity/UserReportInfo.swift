//
//  UserReportInfo.swift
//  DomainReport
//
//  Created by 임현규 on 8/12/24.
//

import Foundation

public struct UserReportInfo {
  public let reason: String
  public let userId: Int
  
  public init(reason: String, userId: Int) {
    self.reason = reason
    self.userId = userId
  }
}
