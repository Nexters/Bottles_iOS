//
//  ProfileClient.swift
//  DomainProfileInterface
//
//  Created by 임현규 on 7/29/24.
//

import Foundation
import ComposableArchitecture

public struct ProfileClient {
  private var checkExistIntroduction: () async throws -> Bool
  
  public init(checkExistIntroduction: @escaping () async throws -> Bool) {
    self.checkExistIntroduction = checkExistIntroduction
  }
  
  public func checkExistIntroduction() async throws -> Bool {
    try await checkExistIntroduction()
  }
}
