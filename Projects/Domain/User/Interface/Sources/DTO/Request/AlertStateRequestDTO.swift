//
//  AlertStateRequestDTO.swift
//  DomainUserInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation

public struct AlertStateRequestDTO: Encodable {
  public let alimyType: AlertType.RawValue
  public let enabled: Bool
  
  public init(alertType: AlertType, enabled: Bool) {
    self.alimyType = alertType.rawValue
    self.enabled = enabled
  }
}
