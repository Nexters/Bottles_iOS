//
//  UpdatePushNotificationAllowStatusRequestDTO.swift
//  DomainUserInterface
//
//  Created by JongHoon on 11/3/24.
//

import Foundation

public struct UpdatePushNotificationAllowStatusRequestDTO: Encodable {
  public let alimyTurnedOn: Bool
  public let deviceName: String
  public let appVersion: String
  public let deviceId: String
  
  public init(
    turnOn: Bool,
    deviceName: String,
    appVersion: String,
    deviceId: String
  ) {
    self.alimyTurnedOn = turnOn
    self.deviceName = deviceName
    self.appVersion = appVersion
    self.deviceId = deviceId
  }
}
