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
        let isExistIntroduction = try await networkManager.reqeust(api: .apiType(ProfileAPI.checkIntroduction), dto: IntroductionExistResponseDTO.self)
        guard let isExist = isExistIntroduction.isExist else { return false }
        return isExist
      },
      registerIntroduction: { answer in
        let requestData = RegisterIntroductionRequestDTO(introduction: [IntroductionReqeustDTO(answer: answer, question: "")])
        try await networkManager.reqeust(
          api: .apiType(ProfileAPI.registerIntroduction(requestData: requestData))
        )
      },
      fetchProfileSelect: {
        let responseData = try await networkManager.reqeust(api: .apiType(ProfileAPI.fetchProfile), dto: ProfileResponseDTO.self)
        let userProfile = responseData.toProfileDomain()
        return userProfile.profileSelect
      },
      uploadProfileImage: { imageData in
        try await networkManager.reqeust(api: .apiType(ProfileAPI.uploadProfileImage(data: imageData)))
      },
      fetchUserProfile: {
        let responseData = try await networkManager.reqeust(api: .apiType(ProfileAPI.fetchProfile), dto: ProfileResponseDTO.self)
        let userProfile = responseData.toProfileDomain()
        return userProfile
      },
      checkIsExistProfileSelect: {
        let responseData = try await networkManager.reqeust(api: .apiType(ProfileAPI.fetchUserProfileStatus), dto: ProfileStatusResponseDTO.self)
        let userStatus = responseData.toDomain()
        return userStatus == .empty ? false : true
      }
    )
  }
}

extension DependencyValues {
  public var profileClient: ProfileClient {
    get { self[ProfileClient.self] }
    set { self[ProfileClient.self] = newValue }
  }
}
