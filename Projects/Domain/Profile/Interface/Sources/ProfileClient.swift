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
  private var fetchUserProfile: () async throws -> UserProfile
  private var uploadProfileImage: (Data) async throws -> Void
  
  public init(
    checkExistIntroduction: @escaping () async throws -> Bool,
    registerIntroduction: @escaping (String) async throws -> Void,
    fetchUserProfile: @escaping () async throws -> UserProfile,
    uploadProfileImage: @escaping (Data) async throws -> Void
  ) {
    self.checkExistIntroduction = checkExistIntroduction
    self.registerIntroduction = registerIntroduction
    self.fetchUserProfile = fetchUserProfile
    self.uploadProfileImage = uploadProfileImage
  }
  
  public func checkExistIntroduction() async throws -> Bool {
    try await checkExistIntroduction()
  }
  
  public func registerIntroduction(answer: String) async throws -> Void {
    try await registerIntroduction(answer)
  }
  
  public func fetchUserProfile() async throws -> UserProfile {
    try await fetchUserProfile()
  }
  
  public func uploadProfileImage(imageData: Data) async throws {
    try await uploadProfileImage(imageData)
  }
}
 
