//
//  MatchingActivateRequestDTO.swift
//  DomainProfileInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation

public struct MatchingActivateRequestDTO: Encodable {
  private let activate: Bool
  
  public init(activate: Bool) {
    self.activate = activate
  }
}
