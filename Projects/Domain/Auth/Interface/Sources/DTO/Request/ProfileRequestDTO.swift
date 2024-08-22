//
//  ProfileRequestDTO.swift
//  DomainAuth
//
//  Created by 임현규 on 8/21/24.
//

import Foundation

public struct ProfileRequestDTO: Encodable {
  let birthDay: Int?
  let birthMonth: Int?
  let birthYear: Int?
  let gender: String?
  let name: String
  
  public init(
    birthDay: Int? = nil,
    birthMonth: Int? = nil,
    birthYear: Int? = nil,
    gender: String? = nil,
    name: String
  ) {
    self.birthDay = birthDay
    self.birthMonth = birthMonth
    self.birthYear = birthYear
    self.gender = gender
    self.name = name
  }
}
