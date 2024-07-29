//
//  BottleClient.swift
//  DomainBottle
//
//  Created by 임현규 on 7/29/24.
//

import Foundation
import ComposableArchitecture

public struct BottleClient {
  private var fetchNewBottlesCount: () async throws -> Int?
  
  public init(fetchNewBottlesCount: @escaping () async throws -> Int?) {
    self.fetchNewBottlesCount = fetchNewBottlesCount
  }
  
  public func fetchNewBottlesCount() async throws -> Int? {
    try await fetchNewBottlesCount()
  }
}

