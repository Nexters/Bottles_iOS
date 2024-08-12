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
  case registerLetterAnswer(
    bottleID: Int,
    registerLetterAnswerRequestDTO: RegisterLetterAnswerRequestDTO
  )
  case imageShare(
    bottleID: Int,
    imageShareRequestDTO: BottleImageShareRequestDTO
  )
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
    case let .registerLetterAnswer(bottleID, _):
      return "api/v1/bottles/ping-pong/\(bottleID)/letters"
    case let .imageShare(bottleID, _):
      return "api/v1/bottles/ping-pong/\(bottleID)/image"
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
    case .registerLetterAnswer:
      return .post
    case .imageShare:
      return .post
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
    case let .registerLetterAnswer(_, registerLetterAnswerRequestDTO):
      return .requestJSONEncodable(registerLetterAnswerRequestDTO)
    case let .imageShare(_, imageShareRequestDTO):
      return .requestJSONEncodable(imageShareRequestDTO)
    }
  }
}
