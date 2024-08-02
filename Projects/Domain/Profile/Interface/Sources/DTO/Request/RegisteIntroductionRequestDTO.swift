//
//  RegisteIntroductionRequestDTO.swift
//  DomainProfile
//
//  Created by 임현규 on 8/2/24.
//

import Foundation

public struct RegisteIntroductionRequestDTO: Encodable {
  public let answer: String
  public let question: String
  
  public init(answer: String, question: String) {
    self.answer = answer
    self.question = question
  }
}
