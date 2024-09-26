//
//  AlertType.swift
//  DomainUserInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation

public enum AlertType: String, Codable {
  case none = "NONE"
  case randomBottle = "DAILY_RANDOM"
  case arrivalBottle = "RECEIVE_LIKE"
  case pingpong = "PINGPONG"
  case marketing = "MARKETING"
}
