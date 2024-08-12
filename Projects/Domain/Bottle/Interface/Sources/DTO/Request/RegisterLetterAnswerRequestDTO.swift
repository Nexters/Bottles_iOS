//
//  RegisterLetterAnswerRequestDTO.swift
//  DomainBottle
//
//  Created by JongHoon on 8/12/24.
//

public struct RegisterLetterAnswerRequestDTO: Encodable {
  public let answer: String
  public let order: Int
  
  public init(
    answer: String,
    order: Int
  ) {
    self.answer = answer
    self.order = order
  }
}
