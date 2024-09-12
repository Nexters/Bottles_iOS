//
//  AuthAPI.swift
//  DomainAuth
//
//  Created by 임현규 on 7/31/24.
//

import Foundation

import CoreNetworkInterface

import Moya

public enum AuthAPI {
  case kakao(_ requestDTO: SignInRequestDTO)
  case apple(_ requestDTO: SignInRequestDTO)
  case withdraw
  case logout(_ logOutRequestDTO: LogOutRequestDTO)
  case revoke
  case profile(_ requestDTO: ProfileRequestDTO)
  case updateVersion
}

extension AuthAPI: BaseTargetType {
  public var path: String {
    switch self {
    case .kakao:
      return "api/v1/auth/kakao"
    case .apple:
      return "api/v1/auth/apple"
    case .withdraw:
      return "api/v1/auth/delete"
    case .logout:
      return "api/v1/auth/logout"
    case .revoke:
      return "api/v1/auth/apple/revoke"
    case .profile:
      return "api/v2/auth/profile"
    case .updateVersion:
      return "api/v1/auth/app-version"
    }
  }
  
  public var method: Moya.Method {
    switch self {
    case .kakao:
      return .post
    case .apple:
      return .post
    case .withdraw:
      return .post
    case .logout:
      return .post
    case .revoke:
      return .get
    case .profile:
      return .post
    case .updateVersion:
      return .get
    }
  }
  
  public var task: Moya.Task {
    switch self {
    case .kakao(let requestDTO):
      return .requestJSONEncodable(requestDTO)
    case .apple(let requestDTO):
      return .requestJSONEncodable(requestDTO)
    case .withdraw:
      return .requestPlain
    case let .logout(logOutRequestDTO):
      return .requestJSONEncodable(logOutRequestDTO)
    case .revoke:
      return .requestPlain
    case .profile(let requestDTO):
      return .requestJSONEncodable(requestDTO)
    case .updateVersion:
      return .requestPlain
    }
  }
}
