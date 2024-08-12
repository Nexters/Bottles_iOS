//
//  BottleImageShareRequestDTO.swift
//  DomainBottle
//
//  Created by JongHoon on 8/12/24.
//

public struct BottleImageShareRequestDTO: Encodable {
  public let willShare: Bool
  
  public init(willShare: Bool) {
    self.willShare = willShare
  }
}
