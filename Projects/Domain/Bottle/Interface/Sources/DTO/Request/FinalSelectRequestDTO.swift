//
//  FinalSelectRequestDTO.swift
//  DomainBottle
//
//  Created by JongHoon on 8/12/24.
//

public struct FinalSelectRequestDTO: Encodable {
  public let willMatch: Bool
  
  public init(willMatch: Bool) {
    self.willMatch = willMatch
  }
}
