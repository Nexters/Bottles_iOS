//
//  BlockContactRequestDTO.swift
//  DomainUserInterface
//
//  Created by JongHoon on 9/22/24.
//

public struct BlockContactRequestDTO: Encodable {
  private let blockContacts: [String]
  
  public init(blockContacts: [String]) {
    self.blockContacts = blockContacts
  }
}
