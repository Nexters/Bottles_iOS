//
//  AlertState.swift
//  DomainUserInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation

public struct UserAlertState {
  public let alertType: AlertType
  public let enabled: Bool
  
  public init(
    alertType: AlertType,
    enabled: Bool
  ) {
    self.alertType = alertType
    self.enabled = enabled
  }
}
