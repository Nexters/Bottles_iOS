//
//  ProfileAPI.swift
//  DomainProfileInterface
//
//  Created by 임현규 on 7/29/24.
//

import CoreNetworkInterface

import Moya

public enum ProfileAPI {
  case fetchProfile
  case registerIntroduction(requestData: RegisterIntroductionRequestDTO)
}

extension ProfileAPI: BaseTargetType {
  public var path: String {
    switch self {
    case .fetchProfile:
      return "api/v1/profile"
    case .registerIntroduction:
      return "api/v1/profile/introduction"
    }
  }
  
  public var method: Moya.Method {
    switch self {
    case .fetchProfile:       
      return .get
    case .registerIntroduction: 
      return .post
    }
  }
  
  public var task: Moya.Task {
    switch self {
    case .fetchProfile:
      return .requestPlain
    case .registerIntroduction(let requestData):
      return .requestJSONEncodable(requestData)
    }
  }
}
