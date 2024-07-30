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
}

extension ProfileAPI: BaseTargetType {
  public var path: String {
    switch self {
    case .fetchProfile:
      return "api/v1/profile"
    }
  }
  
  public var method: Moya.Method {
    switch self {
    case .fetchProfile:       return .get
    }
  }
  
  public var task: Moya.Task {
    switch self {
    case .fetchProfile:       return .requestPlain
    }
  }
}
