//
//  UserClient.swift
//  DomainUser
//
//  Created by 임현규 on 8/22/24.
//

import Foundation

import DomainUserInterface

import CoreKeyChainStore

import ComposableArchitecture

extension UserClient: DependencyKey {
  static public var liveValue: UserClient = .live()
  
  static func live() -> UserClient {
    return .init(
      isLoggedIn: {
        return UserDefaults.standard.bool(forKey: "loginState")
      },
      
      isAppDeleted: {
        return !UserDefaults.standard.bool(forKey: "deleteState")
      },
      
      fetchFcmToken: {
        return UserDefaults.standard.string(forKey: "fcmToken")
      },
      
      updateLoginState: { isLoggedIn in
        UserDefaults.standard.set(isLoggedIn, forKey: "loginState")
      },
      
      updateDeleteState: { isDelete in
        UserDefaults.standard.set(!isDelete, forKey: "deleteState")
      },
      
      updateFcmToken: { fcmToken in
        UserDefaults.standard.set(fcmToken, forKey: "fcmToken")
      }
    )
  }
}

extension DependencyValues {
  public var userClient: UserClient {
    get { self[UserClient.self] }
    set { self[UserClient.self] = newValue }
  }
}
