//
//  BottleAPI.swift
//  DomainBottleInterface
//
//  Created by 임현규 on 7/29/24.
//

import CoreNetworkInterface

import Moya

public enum BottleAPI {
  case fetchBottles
}

extension BottleAPI: BaseTargetType {
  public var path: String {
    switch self {
    case .fetchBottles:
      return "api/v1/bottles"
    }
  }
  
  public var method: Moya.Method {
    switch self {
    case .fetchBottles:
      return .get
    }
  }
  
  public var task: Moya.Task {
    switch self {
    case .fetchBottles:
      return .requestPlain
    }
  }
  
  
}
