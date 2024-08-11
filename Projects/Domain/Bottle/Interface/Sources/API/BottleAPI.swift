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
  case fetchBottleStorageList
  case fetchBottlePingPong(bottleID: Int)
}

extension BottleAPI: BaseTargetType {
  public var path: String {
    switch self {
    case .fetchBottles:
      return "api/v1/bottles"
    case .fetchBottleStorageList:
      return "api/v1/bottles/ping-pong"
    case let .fetchBottlePingPong(bottleID):
      return "api/v1/bottles/ping-pong/\(bottleID)"
    }
  }
  
  public var method: Moya.Method {
    switch self {
    case .fetchBottles:
      return .get
    case .fetchBottleStorageList:
      return .get
    case .fetchBottlePingPong:
      return .get
    }
  }
  
  public var task: Moya.Task {
    switch self {
    case .fetchBottles:
      return .requestPlain
    case .fetchBottleStorageList:
      return .requestPlain
    case .fetchBottlePingPong:
      return .requestPlain
    }
  }
}
