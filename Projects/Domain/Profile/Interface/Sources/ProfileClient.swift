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
  private var registerIntroduction: (String) async throws -> Void
  private var fetchProfileSelect: () async throws -> ProfileSelect
  private var uploadProfileImage: (Data) async throws -> Void
  private var fetchUserProfile: () async throws -> UserProfile

  
  public init(
    checkExistIntroduction: @escaping () async throws -> Bool,
    registerIntroduction: @escaping (String) async throws -> Void,
    fetchProfileSelect: @escaping () async throws -> ProfileSelect,
    uploadProfileImage: @escaping (Data) async throws -> Void,
    fetchUserProfile: @escaping () async throws -> UserProfile
  ) {
    self.checkExistIntroduction = checkExistIntroduction
    self.registerIntroduction = registerIntroduction
    self.fetchProfileSelect = fetchProfileSelect
    self.uploadProfileImage = uploadProfileImage
    self.fetchUserProfile = fetchUserProfile
  }
  
  public func checkExistIntroduction() async throws -> Bool {
    try await checkExistIntroduction()
  }
  
  public func registerIntroduction(answer: String) async throws -> Void {
    try await registerIntroduction(answer)
  }
  
  public func fetchProfileSelect() async throws -> ProfileSelect {
    try await fetchProfileSelect()
  }
  
  public func uploadProfileImage(imageData: Data) async throws {
    try await uploadProfileImage(imageData)
  }
  
  public func fetchUserProfile() async throws -> UserProfile {
    try await fetchUserProfile()
  }
}
 
