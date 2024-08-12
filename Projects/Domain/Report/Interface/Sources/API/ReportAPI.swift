//
//  ReportAPI.swift
//  DomainReportInterface
//
//  Created by 임현규 on 8/12/24.
//

import Foundation

import CoreNetworkInterface

import Moya

public enum ReportAPI {
  case reportUser(requestData: ReportUserRequestDTO)
}

extension ReportAPI: BaseTargetType {
  public var path: String {
    switch self {
    case .reportUser:
      return "/api/v1/user/report"
    }
  }
  
  public var method: Moya.Method {
    switch self {
    case .reportUser:
      return .post
    }
  }
  
  public var task: Moya.Task {
    switch self {
    case .reportUser(let requestData):
      return .requestJSONEncodable(requestData)
    }
  }
  
  
}
