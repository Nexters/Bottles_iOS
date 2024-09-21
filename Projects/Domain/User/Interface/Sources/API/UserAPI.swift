//
//  UserAPI.swift
//  DomainUserInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation

import CoreNetworkInterface

import Moya

public enum UserAPI {
  case fetchAlertState
  case updateAlertState(reqeustData: AlertStateRequestDTO)
}

extension UserAPI: BaseTargetType {
  public var path: String {
    switch self {
    case .fetchAlertState:
      return "api/v1/user/alimy"
    case .updateAlertState:
      return "api/v1/user/alimy"
    }
  }
  
  public var method: Moya.Method {
    switch self {
    case .fetchAlertState:
      return .get
    case .updateAlertState:
      return .post
    }
  }
  
  public var task: Moya.Task {
    switch self {
    case .fetchAlertState:
      return .requestPlain
    case .updateAlertState(let requestData):
      return .requestJSONEncodable(requestData)
    }
  }
}
