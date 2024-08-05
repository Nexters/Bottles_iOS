//
//  RegisterIntroductionRequestDTO.swift
//  DomainProfile
//
//  Created by 임현규 on 8/2/24.
//

import Foundation

public struct RegisterIntroductionRequestDTO: Encodable {
  public let introduction: [IntroductionReqeustDTO]
  
  public init(introduction: [IntroductionReqeustDTO]) {
    self.introduction = introduction
  }
}

public struct IntroductionReqeustDTO: Encodable {
  public let answer: String
  public let question: String
  
  public init(answer: String, question: String) {
    self.answer = answer
    self.question = question
  }
}
