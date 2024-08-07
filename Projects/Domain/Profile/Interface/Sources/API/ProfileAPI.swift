//
//  ProfileAPI.swift
//  DomainProfileInterface
//
//  Created by 임현규 on 7/29/24.
//

import Foundation

import CoreNetworkInterface

import Moya

public enum ProfileAPI {
  case fetchProfile
  case registerIntroduction(requestData: RegisterIntroductionRequestDTO)
  case checkIntroduction
  case uploadProfileImage(data: Data)
}

extension ProfileAPI: BaseTargetType {
  public var path: String {
    switch self {
    case .fetchProfile:
      return "api/v1/profile"
    case .registerIntroduction:
      return "api/v1/profile/introduction"
    case .checkIntroduction:
      return "api/v1/profile/introduction/exist"
    case .uploadProfileImage:
      return "api/v1/profile/images"
    }
  }
  
  public var method: Moya.Method {
    switch self {
    case .fetchProfile:       
      return .get
    case .registerIntroduction: 
      return .post
    case .checkIntroduction:
      return .get
    case .uploadProfileImage:
      return .post
    }
  }
  
  public var task: Moya.Task {
    switch self {
    case .fetchProfile:
      return .requestPlain
    case .registerIntroduction(let requestData):
      return .requestJSONEncodable(requestData)
    case .checkIntroduction:
      return .requestPlain
    case .uploadProfileImage(let data):
      let imageData = MultipartFormData(
        provider: .data(data),
        name: "file",
        fileName: "filename.jpeg",
        mimeType: "image/jpeg"
      )
      
      return .uploadMultipart([imageData])
    }
  }
}
