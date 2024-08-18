//
//  ProfileClient.swift
//  DomainProfileInterface
//
//  Created by 임현규 on 7/29/24.
//

import Foundation
import ComposableArchitecture

public struct ProfileClient {
  private var checkIsExistIntroduction: () async throws -> Bool
  private var registerIntroduction: (String) async throws -> Void
  private var fetchProfileSelect: () async throws -> ProfileSelect
  private var uploadProfileImage: (Data) async throws -> Void
  private var fetchUserProfile: () async throws -> UserProfile
  private var checkIsExistProfileSelect: () async throws -> Bool
  
  public init(
    checkIsExistIntroduction: @escaping () async throws -> Bool,
    registerIntroduction: @escaping (String) async throws -> Void,
    fetchProfileSelect: @escaping () async throws -> ProfileSelect,
    uploadProfileImage: @escaping (Data) async throws -> Void,
    fetchUserProfile: @escaping () async throws -> UserProfile,
    checkIsExistProfileSelect: @escaping () async throws -> Bool
  ) {
    self.checkIsExistIntroduction = checkIsExistIntroduction
    self.registerIntroduction = registerIntroduction
    self.fetchProfileSelect = fetchProfileSelect
    self.uploadProfileImage = uploadProfileImage
    self.fetchUserProfile = fetchUserProfile
    self.checkIsExistProfileSelect = checkIsExistProfileSelect
  }
  
  public func checkIsExistIntroduction() async throws -> Bool {
    try await checkIsExistIntroduction()
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
  
  public func checkIsExistProfileSelect() async throws -> Bool {
    try await checkIsExistProfileSelect()
  }
}
 
