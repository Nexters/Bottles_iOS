//
//  AlertStateReponseDTO.swift
//  DomainUserInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation

public struct AlertStateReponseDTO: Decodable {
  public let alertStateList: [AlertStateDTO]
  
  public struct AlertStateDTO: Decodable {
    let alertType: String
    let enabled: Bool
    
    public func toDomain() -> AlertState {
      return .init(
        alertType: AlertType(rawValue: alertType) ?? .none,
        enabled: enabled
      )
    }
  }
  
  public func toDomain() -> [AlertState] {
    return alertStateList.map { $0.toDomain() }
  }
}
