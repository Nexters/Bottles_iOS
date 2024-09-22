//
//  UserClient.swift
//  DomainUser
//
//  Created by 임현규 on 8/22/24.
//

import Foundation
import Contacts

import DomainUserInterface

import CoreKeyChainStore
import CoreNetwork

import ComposableArchitecture
import Moya

extension UserClient: DependencyKey {
  private enum UserDefaultsKeys: String {
    case loginState
    case deleteState
    case fcmToken
    case alertAllowState
  }
  
  static public var liveValue: UserClient = .live()
  
  static func live() -> UserClient {
    @Dependency(\.network) var networkManager
    
    return .init(
      isLoggedIn: {
        return UserDefaults.standard.bool(forKey: UserDefaultsKeys.loginState.rawValue)
      },
      
      isAppDeleted: {
        return !UserDefaults.standard.bool(forKey: UserDefaultsKeys.deleteState.rawValue)
      },
      
      fetchFcmToken: {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.fcmToken.rawValue)
      },
      
      updateLoginState: { isLoggedIn in
        UserDefaults.standard.set(isLoggedIn, forKey: UserDefaultsKeys.loginState.rawValue)
      },
      
      updateDeleteState: { isDelete in
        UserDefaults.standard.set(!isDelete, forKey: UserDefaultsKeys.deleteState.rawValue)
      },
      
      updateFcmToken: { fcmToken in
        UserDefaults.standard.set(fcmToken, forKey: UserDefaultsKeys.fcmToken.rawValue)
      },
      
      updatePushNotificationAllowStatus: { isAllow in
        UserDefaults.standard.set(isAllow, forKey: UserDefaultsKeys.alertAllowState.rawValue)
      },
      
      fetchAlertState: {
        let responseData = try await networkManager.reqeust(api: .apiType(UserAPI.fetchAlertState), dto: [AlertStateResponseDTO].self)
        return responseData.map { $0.toDomain() }
      },
      
      fetchPushNotificationAllowStatus: {
        return UserDefaults.standard.bool(forKey: UserDefaultsKeys.alertAllowState.rawValue)
      },
      updateAlertState: { alertState in
        let requestData = AlertStateRequestDTO(alertType: alertState.alertType, enabled: alertState.enabled)
        try await networkManager.reqeust(api: .apiType(UserAPI.updateAlertState(reqeustData: requestData)))
      },
      fetchContacts: {
        let store = CNContactStore()
        var contacts: [String] = []
        let keys = [CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        
        let request = CNContactFetchRequest(keysToFetch: keys)
        request.sortOrder = CNContactSortOrder.userDefault
        
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        guard authorizationStatus == .authorized ||
                authorizationStatus == .notDetermined
        else {
          throw UserError.contactsAccessDenied
        }
        
        let granted = try await store.requestAccess(for: .contacts)
        guard granted
        else {
          throw UserError.requestContactsAccessAuthorityFailed
        }
        
        try store.enumerateContacts(with: request) { contact, _ in
          contacts += contact.phoneNumbers
            .map { $0.value.stringValue }
            .map { $0.replacingOccurrences(of: "+82", with: "0") }
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .map { $0.filter { $0.isNumber } }
        }
        
        return contacts
      },
      updateBlockContacts: { contacts in
        let blockContactRequestDTO = BlockContactRequestDTO(blockContacts: contacts)
        try await networkManager.reqeust(api: .apiType(UserAPI.updateBlockContacts(blockContactRequestDTO: blockContactRequestDTO)))
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
