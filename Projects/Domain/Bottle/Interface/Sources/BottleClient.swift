//
//  BottleClient.swift
//  DomainBottle
//
//  Created by 임현규 on 7/29/24.
//

import Foundation
import ComposableArchitecture

public struct BottleClient {
  private let fetchNewBottlesCount: () async throws -> Int
  private let fetchBottleStorageList: () async throws -> BottleStorageList
  private let fetchBottlePingPong: (_ bottleID: Int) async throws -> BottlePingPong
  private let registerLetterAnswer: (_ bottleID: Int, _ order: Int, _ answer: String) async throws -> Void
  
  public init(
    fetchNewBottlesCount: @escaping () async throws -> Int,
    fetchBottleStorageList: @escaping () async throws -> BottleStorageList,
    fetchBottlePingPong: @escaping (_ bottleID: Int) async throws -> BottlePingPong,
    registerLetterAnswer: @escaping (_ bottleID: Int, _ order: Int, _ answer: String) async throws -> Void
  ) {
    self.fetchNewBottlesCount = fetchNewBottlesCount
    self.fetchBottleStorageList = fetchBottleStorageList
    self.fetchBottlePingPong = fetchBottlePingPong
    self.registerLetterAnswer = registerLetterAnswer
  }
  
  public func fetchNewBottlesCount() async throws -> Int {
    try await fetchNewBottlesCount()
  }
  
  public func fetchBottleStorageList() async throws -> BottleStorageList {
    try await fetchBottleStorageList()
  }
  
  public func fetchBottlePingPong(bottleID: Int) async throws -> BottlePingPong {
    try await fetchBottlePingPong(bottleID)
  }
  
  public func registerLetterAnswer(bottleID: Int, order: Int, answer: String) async throws {
    try await registerLetterAnswer(bottleID, order, answer)
  }
}
