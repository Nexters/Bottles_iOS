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
  static public var liveValue: UserClient = .live()
  
  static func live() -> UserClient {
    @Dependency(\.network) var networkManager
    
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
      },
      
      fetchAlertState: {
        let responseData = try await networkManager.reqeust(api: .apiType(UserAPI.fetchAlertState), dto: [AlertStateResponseDTO].self)
        return responseData.map { $0.toDomain() }
        
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
          contact.phoneNumbers.forEach { phoneNumber in
            var finalPhoneNumber = phoneNumber.value.stringValue
            if finalPhoneNumber.hasPrefix("+82") {
              finalPhoneNumber = finalPhoneNumber.replacingOccurrences(of: "+82", with: "0")
            }
            finalPhoneNumber = finalPhoneNumber.trimmingCharacters(in: .whitespaces)
            finalPhoneNumber = finalPhoneNumber.filter { $0.isNumber }
            contacts.append(finalPhoneNumber)
          }
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
