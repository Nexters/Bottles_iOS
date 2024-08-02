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
      checkExistIntroduction: {
        let profile = try await networkManager.reqeust(api: .apiType(ProfileAPI.fetchProfile), dto: ProfileResponseDTO.self)
        return profile.introduction != nil ? true : false
      },
      registerIntroduction: { answer in
        let requestData = RegisterIntroductionRequestDTO(answer: answer, question: "")
        _ = try await networkManager.reqeust(
          api: .apiType(ProfileAPI.registerIntroduction(requestData: requestData))
        )
      }
    )
  }
}

extension ProfileClient {
  static public var previewValue = Self(
    checkExistIntroduction: { false },
    registerIntroduction: { introduction in }
    )
}

extension DependencyValues {
  public var profileClient: ProfileClient {
    get { self[ProfileClient.self] }
    set { self[ProfileClient.self] = newValue }
  }
}
