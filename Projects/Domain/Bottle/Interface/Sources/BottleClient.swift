//
//  BottleClient.swift
//  DomainBottle
//
//  Created by 임현규 on 7/29/24.
//

import Foundation
import ComposableArchitecture

public struct BottleClient {
  private let fetchUserBottleInfo: () async throws -> UserBottleInfo
  private let fetchBottleStorageList: () async throws -> BottleStorageList
  private let fetchBottlePingPong: (_ bottleID: Int) async throws -> BottlePingPong
  private let registerLetterAnswer: (_ bottleID: Int, _ order: Int, _ answer: String) async throws -> Void
  private let shareImage: (_ bottleID: Int, _ willShare: Bool) async throws -> Void
  private let finalSelect: (_ bottleID: Int, _ willMatch: Bool) async throws -> Void
  private let stopTalk: (_ bottleID: Int) async throws -> Void
  
  public init(
    fetchUserBottleInfo: @escaping () async throws -> UserBottleInfo,
    fetchBottleStorageList: @escaping () async throws -> BottleStorageList,
    fetchBottlePingPong: @escaping (_ bottleID: Int) async throws -> BottlePingPong,
    registerLetterAnswer: @escaping (_ bottleID: Int, _ order: Int, _ answer: String) async throws -> Void,
    shareImage: @escaping (_ bottleID: Int, _ willShare: Bool) async throws -> Void,
    finalSelect: @escaping (_ bottleID: Int, _ willMatch: Bool) async throws -> Void,
    stopTalk: @escaping (_ bottleID: Int) async throws -> Void
  ) {
    self.fetchUserBottleInfo = fetchUserBottleInfo
    self.fetchBottleStorageList = fetchBottleStorageList
    self.fetchBottlePingPong = fetchBottlePingPong
    self.registerLetterAnswer = registerLetterAnswer
    self.shareImage = shareImage
    self.finalSelect = finalSelect
    self.stopTalk = stopTalk
  }
  
  public func fetchUserBottleInfo() async throws -> UserBottleInfo {
    try await fetchUserBottleInfo()
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
  
  public func shareImage(bottleID: Int, willShare: Bool) async throws {
    try await shareImage(bottleID, willShare)
  }
  
  public func finalSelect(bottleID: Int, willMatch: Bool) async throws {
    try await finalSelect(bottleID, willMatch)
  }
  
  public func stopTalk(bottleID: Int) async throws {
    try await stopTalk(bottleID)
  }
}
