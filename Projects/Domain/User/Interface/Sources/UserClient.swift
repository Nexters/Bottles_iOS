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
  private let updatePushNotificationAllowStatus: (Bool) -> Void
  private let _fetchAlertState: () async throws -> [UserAlertState]
  private let _fetchPushNotificationAllowStatus: () -> Bool
  private let updateAlertState: (UserAlertState) async throws -> Void
  private let fetchContacts: () async throws -> [String]
  private let updateBlockContacts: ([String]) async throws -> Void
  
  public init(
    isLoggedIn: @escaping () -> Bool,
    isAppDeleted: @escaping () -> Bool,
    fetchFcmToken: @escaping () -> String?,
    updateLoginState: @escaping (Bool) -> Void,
    updateDeleteState: @escaping (Bool) -> Void,
    updateFcmToken: @escaping (String) -> Void,
    updatePushNotificationAllowStatus: @escaping (Bool) -> Void,
    fetchAlertState: @escaping () async throws -> [UserAlertState],
    fetchPushNotificationAllowStatus: @escaping () -> Bool,
    updateAlertState: @escaping (UserAlertState) async throws -> Void,
    fetchContacts: @escaping () async throws -> [String],
    updateBlockContacts: @escaping ([String]) async throws -> Void
  ) {
    self._isLoggedIn = isLoggedIn
    self._isAppDeleted = isAppDeleted
    self._fetchFcmToken = fetchFcmToken
    self.updateLoginState = updateLoginState
    self.updateDeleteState = updateDeleteState
    self.updateFcmToken = updateFcmToken
    self.updatePushNotificationAllowStatus = updatePushNotificationAllowStatus
    self._fetchAlertState = fetchAlertState
    self._fetchPushNotificationAllowStatus = fetchPushNotificationAllowStatus
    self.updateAlertState = updateAlertState
    self.fetchContacts = fetchContacts
    self.updateBlockContacts = updateBlockContacts
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
  
  public func updatePushNotificationAllowStatus(isAllow: Bool) {
    updatePushNotificationAllowStatus(isAllow)
  }
  
  public func fetchAlertState() async throws -> [UserAlertState] {
    try await _fetchAlertState()
  }
  
  public func fetchPushNotificationAllowStatus() -> Bool {
    _fetchPushNotificationAllowStatus()
  }
  
  public func updateAlertState(alertState: UserAlertState) async throws {
    try await updateAlertState(alertState)
  }
  
  public func fetchContacts() async throws -> [String] {
    try await fetchContacts()
  }
  
  public func updateBlockContacts(contacts: [String]) async throws {
    try await updateBlockContacts(contacts)
  }
}
