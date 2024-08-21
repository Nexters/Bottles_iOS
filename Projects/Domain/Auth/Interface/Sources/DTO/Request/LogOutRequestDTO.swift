//
//  LogOutRequestDTO.swift
//  DomainAuthInterface
//
//  Created by JongHoon on 8/21/24.
//

public struct LogOutRequestDTO: Encodable {
  let fcmDeviceToken: String
  
  public init(fcmDeviceToken: String) {
    self.fcmDeviceToken = fcmDeviceToken
  }
}
