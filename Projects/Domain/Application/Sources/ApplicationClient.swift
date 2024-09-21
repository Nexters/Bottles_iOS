//
//  ApplicationClient.swift
//  DomainApplicationInterface
//
//  Created by JongHoon on 9/22/24.
//

import Foundation

import DomainApplicationInterface
import DomainErrorInterface

import CoreURLHandlerInterface
import CoreURLHandler

import Dependencies

extension ApplicationClient: DependencyKey {
  static public var liveValue: ApplicationClient = .live()
  
  static func live() -> ApplicationClient {
    @Dependency(\.applicationClient) var applicationClient
    return .init(
      fetchCurrentAppVersion: {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        return version
      },
      fetchLatestAppVersion: {
        let appLookUpURL = BottleURLType.bottleAppLookUp.url
        let (data, _) = try await URLSession.shared.data(from: appLookUpURL)
        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let results = json["results"] as? [[String: Any]],
           let appStoreVersion = results.first?["version"] as? String {
          return appStoreVersion
        } else {
          throw DomainError.unknown("fetch latest app version failed")
        }
      },
      checkNeedApplicationUpdate: {
        let currentAppVersion = applicationClient.fetchCurrentAppVersion()
        let latestAppVersion = try await applicationClient.fetchLatestAppVersion()
        let currentAppVersionArray = currentAppVersion.split(separator: ".").compactMap { Int($0) }
        let latestAppVersionArray = latestAppVersion.split(separator: ".").compactMap { Int($0) }
        
        let maxLength = max(currentAppVersionArray.count, latestAppVersionArray.count)
        
        for i in 0..<maxLength {
          let currentVersion = i < currentAppVersionArray.count ? currentAppVersionArray[i] : 0
          let latestVersion = i < latestAppVersionArray.count ? latestAppVersionArray[i] : 0
          
          if latestVersion > currentVersion {
            return true
          }
        }
        return false
      }
    )
  }
}

extension DependencyValues {
  public var applicationClient: ApplicationClient {
    get { self[ApplicationClient.self] }
    set { self[ApplicationClient.self] = newValue }
  }
}
