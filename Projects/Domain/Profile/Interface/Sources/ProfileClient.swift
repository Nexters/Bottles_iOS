//
//  ProfileClient.swift
//  DomainProfileInterface
//
//  Created by 임현규 on 7/29/24.
//

import Foundation
import ComposableArchitecture

public struct ProfileClient {
  private var fetchUserState: () async throws -> UserStateType
  
  public init(fetchUserState: @escaping () async throws -> UserStateType) {
    self.fetchUserState = fetchUserState
  }
  
  public func fetchUserState() async throws -> UserStateType {
    try await fetchUserState()
  }
}
