//
//  AlertType.swift
//  DomainUserInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation

public enum AlertType: String, Encodable {
  case randomBottle = "DAILY_RANDOM"
  case ArrivalBottle = "RECEIVE_LIKE"
  case pingpong = "PINGPONG"
  case marketing = "MARKETING"
}
