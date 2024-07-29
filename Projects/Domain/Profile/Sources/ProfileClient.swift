//
//  ProfileClient.swift
//  DomainProfileInterface
//
//  Created by 임현규 on 7/29/24.
//

import DomainProfileInterface
import CoreNetwork

import ComposableArchitecture
import Moya

extension ProfileClient: DependencyKey {
  public static let liveValue: ProfileClient = .live()
  
  private static func live() -> ProfileClient {
    @Dependency(\.network) var networkManager
    
    return .init(
      fetchUserState: {
        let profile = try await networkManager.reqeust(api: .apiType(ProfileAPI.fetchProfile), dto: ProfileResponseDTO.self)
        return profile.introduction == nil ? .noIntroduction : .noBottle
      }
    )
  }
}

extension ProfileClient {
  static public var previewValue = Self(
    fetchUserState: { UserStateType.hasBottle })
}

extension DependencyValues {
  public var profileClient: ProfileClient {
    get { self[ProfileClient.self] }
    set { self[ProfileClient.self] = newValue }
  }
}
