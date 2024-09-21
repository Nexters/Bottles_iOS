//
//  UserClient.swift
//  DomainUserInterface
//
//  Created by 임현규 on 8/22/24.
//

import Foundation

public struct UserClient {
  private let _isLoggedIn: () -> Bool
  private let _isAppDeleted: () -> Bool
  private let _fetchFcmToken: () -> String?
  private let updateLoginState: (Bool) -> Void
  private let updateDeleteState: (Bool) -> Void
  private let updateFcmToken: (String) -> Void
  private let _fetchAlertState: () async throws -> [UserAlertState]
  private let updateAlertState: (UserAlertState) async throws -> Void
  
  
  public init(
    isLoggedIn: @escaping () -> Bool,
    isAppDeleted: @escaping () -> Bool,
    fetchFcmToken: @escaping () -> String?,
    updateLoginState: @escaping (Bool) -> Void,
    updateDeleteState: @escaping (Bool) -> Void,
    updateFcmToken: @escaping (String) -> Void,
    fetchAlertState: @escaping () async throws -> [UserAlertState],
    updateAlertState: @escaping (UserAlertState) async throws -> Void
  ) {
    self._isLoggedIn = isLoggedIn
    self._isAppDeleted = isAppDeleted
    self._fetchFcmToken = fetchFcmToken
    self.updateLoginState = updateLoginState
    self.updateDeleteState = updateDeleteState
    self.updateFcmToken = updateFcmToken
    self._fetchAlertState = fetchAlertState
    self.updateAlertState = updateAlertState
  }
  
  public func isLoggedIn() -> Bool {
    _isLoggedIn()
  }
  
  public func isAppDeleted() -> Bool {
    _isAppDeleted()
  }
  
  public func fetchFcmToken() -> String? {
    _fetchFcmToken()
  }
  
  public func updateLoginState(isLoggedIn: Bool) {
    updateLoginState(isLoggedIn)
  }
  
  public func updateDeleteState(isDelete: Bool) {
    updateDeleteState(isDelete)
  }
  
  public func updateFcmToken(fcmToken: String) {
    updateFcmToken(fcmToken)
  }
  
  public func fetchAlertState() async throws -> [UserAlertState] {
    try await _fetchAlertState()
  }
  
  public func updateAlertState(alertState: UserAlertState) async throws {
    try await updateAlertState(alertState)
  }
}
