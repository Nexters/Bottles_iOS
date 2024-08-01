//
//  RefreshAPI.swift
//  CoreNetwork
//
//  Created by 임현규 on 8/1/24.
//

import Moya
import CoreNetworkInterface

enum RefreshAPI {
  case refresh
}

extension RefreshAPI: BaseTargetType {
  var path: String {
    return "api/v1/auth/refresh"
  }
  
  var method: Moya.Method {
    return .post
  }
  
  var task: Moya.Task {
    return .requestPlain
  }
}
