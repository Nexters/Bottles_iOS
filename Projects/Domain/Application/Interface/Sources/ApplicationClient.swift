//
//  ApplicationClient.swift
//  DomainApplicationInterface
//
//  Created by JongHoon on 9/22/24.
//

import Foundation

public struct ApplicationClient {
  private let _fetchCurrentAppVersion: () -> String
  private let fetchLatestAppVersion: () async throws -> String
  private let checkNeedApplicationUpdate: () async throws -> Bool
  
  public init(
    fetchCurrentAppVersion: @escaping () -> String,
    fetchLatestAppVersion: @escaping () async throws -> String,
    checkNeedApplicationUpdate: @escaping () async throws -> Bool
  ) {
    self._fetchCurrentAppVersion = fetchCurrentAppVersion
    self.fetchLatestAppVersion = fetchLatestAppVersion
    self.checkNeedApplicationUpdate = checkNeedApplicationUpdate
  }
  
  public func fetchCurrentAppVersion() -> String {
    _fetchCurrentAppVersion()
  }
  
  public func fetchLatestAppVersion() async throws -> String {
    try await fetchLatestAppVersion()
  }
  
  public func checkNeedApplicationUpdate() async throws -> Bool {
    try await checkNeedApplicationUpdate()
  }
}
