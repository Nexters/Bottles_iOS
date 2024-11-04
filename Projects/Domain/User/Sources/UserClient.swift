//
//  UserClient.swift
//  DomainUser
//
//  Created by 임현규 on 8/22/24.
//

import UIKit
import Foundation
import UserNotifications
import Contacts

import DomainUserInterface

import CoreKeyChainStore
import CoreNetwork
import CoreLoggerInterface
import SharedUtilInterface

import ComposableArchitecture
import Moya

extension UserClient: DependencyKey {
  private enum UserDefaultsKeys: String {
    case loginState
    case deleteState
    case fcmToken
    case alertAllowState
    case remotelyUploadedPushNotificationAllowStatus
    case coachMarkState
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
      
      isCoachMarkViewed: {
        return UserDefaults.standard.bool(forKey: UserDefaultsKeys.coachMarkState.rawValue)
      },
      
      fetchFcmToken: {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.fcmToken.rawValue)
      },
      
      remotelyUploadedPushNotificationAllowStatus: {
        let status = UserDefaults.standard.object(forKey: UserDefaultsKeys.remotelyUploadedPushNotificationAllowStatus.rawValue)
        guard let status = status as? Bool
        else {
          return nil
        }
        
        return status
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
      
      updatePushNotificationAllowStatusLocally: { isAllow in
        UserDefaults.standard.set(isAllow, forKey: UserDefaultsKeys.alertAllowState.rawValue)
      },
      
      updatePushNotificationAllowStatusRemotely: { isAllow in
        @Dependency(\.userClient) var userClient
        
        var deviceName: String? {
          if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
            return simulatorModelIdentifier
          } else {
            var systemInfo = utsname()
            uname(&systemInfo)
            let modelIdentifier = withUnsafePointer(to: &systemInfo.machine) {
              $0.withMemoryRebound(to: CChar.self, capacity: 1) { ptr in
                String(validatingUTF8: ptr)
              }
            }
            return modelIdentifier
          }
        }
        
        let requestDTO = await UpdatePushNotificationAllowStatusRequestDTO(
          turnOn: isAllow,
          deviceName: deviceName ?? "",
          appVersion: (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "",
          deviceId: UIDevice.current.identifierForVendor?.uuidString ?? ""
        )
        
        try await networkManager.reqeust(api: .apiType(UserAPI.updatePushNotificationAllowStatus(requestDTO: requestDTO)))
        userClient.updateRemotelyUploadedPushNotificationAllowStatus(isAllow: isAllow)
      },
      
      updateRemotelyUploadedPushNotificationAllowStatus: { isAllow in
        UserDefaults.standard.set(isAllow, forKey: UserDefaultsKeys.remotelyUploadedPushNotificationAllowStatus.rawValue)
      },
      
      isNeedUpdatePushNotificationRemotely: {
        @Dependency(\.userClient) var userClient
        
        guard userClient.isLoggedIn()
        else {
          return .notNeed
        }
        
        let remotelyUploadedStatus = userClient.remotelyUploadedPushNotificationAllowStatus()
        let isAuthorized = await withCheckedContinuation { continuation in
          UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
              continuation.resume(returning: false)
              
            case .denied:
              continuation.resume(returning: false)
              
            case .authorized:
              continuation.resume(returning: true)
              
            case .provisional:
              continuation.resume(returning: false)
              
            case .ephemeral:
              continuation.resume(returning: false)
              
            @unknown default:
              continuation.resume(returning: false)
              Log.assertion(message: "not handled status")
            }
          }
        }
        
        let isNeedType: NeedUpdatePushNotificationAllowStatusRemotelyType = switch remotelyUploadedStatus {
        case .none:
            .need(isAllow: isAuthorized)
          
        case let .some(localAllowStatus):
          (localAllowStatus == isAuthorized) ? .notNeed : .need(isAllow: isAuthorized)
        }
        
        return isNeedType
      },
      
      updateCoachMarkState: { isViewed in
        UserDefaults.standard.set(isViewed, forKey: UserDefaultsKeys.coachMarkState.rawValue)
      },
      
      fetchAlertState: {
        let responseData = try await networkManager.reqeust(api: .apiType(UserAPI.fetchAlertState), dto: [AlertStateResponseDTO].self)
        return responseData.map { $0.toDomain() }
      },
      
      fetchPushNotificationAllowStatusLocally: {
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
