//
//  BaseTargetType.swift
//  CoreNetwork
//
//  Created by 임현규 on 7/21/24.
//

import Foundation
import Moya

public protocol BaseTargetType: TargetType {}

public extension BaseTargetType {
  var baseURL: URL {
    guard let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
      return URL(string: "")!
    }
    
    return URL(string: baseURL)!
  }
  
  var headers: [String : String]? {
    return ["Content-type": "application/json"]
  }
  
  var validationType: ValidationType {
    return .successCodes
  }
}
