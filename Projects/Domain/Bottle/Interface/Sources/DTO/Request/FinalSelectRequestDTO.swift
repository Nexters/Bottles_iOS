//
//  FinalSelectRequestDTO.swift
//  DomainBottle
//
//  Created by JongHoon on 8/12/24.
//

public struct FinalSelectRequestDTO: Encodable {
  public let wilMatch: Bool
  
  public init(wilMatch: Bool) {
    self.wilMatch = wilMatch
  }
}
