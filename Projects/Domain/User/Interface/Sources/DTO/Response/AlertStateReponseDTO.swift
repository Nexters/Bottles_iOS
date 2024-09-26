//
//  AlertStateReponseDTO.swift
//  DomainUserInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation

public struct AlertStateResponseDTO: Decodable {
  let alimyType: String
  let enabled: Bool
  
  public func toDomain() -> UserAlertState {
    return .init(
      alertType: AlertType(rawValue: alimyType) ?? .none,
      enabled: enabled
    )
  }
}
