//
//  AnyAPIType.swift
//  CoreNetworkInterface
//
//  Created by 임현규 on 7/22/24.
//

import Moya

public enum AnyAPIType: BaseTargetType {
  case apiType(BaseTargetType)
  
  public init(_ apiType: any BaseTargetType) {
    self = .apiType(apiType)
  }
  
  public var apiType: any BaseTargetType {
    switch self {
    case .apiType(let apiType):
      return apiType
    }
  }
  
  public var path: String { apiType.path }
  
  public var method: Moya.Method { apiType.method }
  
  public var task: Moya.Task { apiType.task }
}
