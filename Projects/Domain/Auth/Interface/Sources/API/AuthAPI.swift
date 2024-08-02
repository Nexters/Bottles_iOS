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
}

extension AuthAPI: BaseTargetType {
  public var path: String {
    switch self {
    case .kakao:
      return "api/v1/auth/kakao"
    }
  }
  
  public var method: Moya.Method {
    switch self {
    case .kakao:
      return .post
    }
  }
  
  public var task: Moya.Task {
    switch self {
    case .kakao(let requestDTO):
      return .requestJSONEncodable(requestDTO)
    }
  }
}
