//
//  UserRegion.swift
//  DomainProfileInterface
//
//  Created by 임현규 on 8/2/24.
//

import Foundation

public struct UserRegion {
  public let city: String
  public let state: String
  
  public init(city: String, state: String) {
    self.city = city
    self.state = state
  }
}
