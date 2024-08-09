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
  private var fetchBottleStorageList: () async throws -> BottleStorageList
  
  public init(
    fetchNewBottlesCount: @escaping () async throws -> Int?,
    fetchBottleStorageList: @escaping () async throws -> BottleStorageList
  ) {
    self.fetchNewBottlesCount = fetchNewBottlesCount
    self.fetchBottleStorageList = fetchBottleStorageList
  }
  
  public func fetchNewBottlesCount() async throws -> Int? {
    try await fetchNewBottlesCount()
  }
  
  public func fetchBottleStorageList() async throws -> BottleStorageList {
    try await fetchBottleStorageList()
  }
}

