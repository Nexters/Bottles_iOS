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
  private let updateLoginState: (Bool) -> Void
  private let updateDeleteState: (Bool) -> Void
  
  public init(
    isLoggedIn: @escaping () -> Bool,
    isAppDeleted: @escaping () -> Bool,
    updateLoginState: @escaping (Bool) -> Void,
    updateDeleteState: @escaping (Bool) -> Void
  ) {
    self._isLoggedIn = isLoggedIn
    self._isAppDeleted = isAppDeleted
    self.updateLoginState = updateLoginState
    self.updateDeleteState = updateDeleteState
  }
  
  public func isLoggedIn() -> Bool {
    _isLoggedIn()
  }
  
  public func isAppDeleted() -> Bool {
    _isAppDeleted()
  }
  
  public func updateLoginState(isLoggedIn: Bool) {
    updateLoginState(isLoggedIn)
  }
  
  public func updateDeleteState(isDelete: Bool) {
    updateDeleteState(isDelete)
  }
}
