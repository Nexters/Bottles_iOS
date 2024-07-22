//
//  Providable.swift
//  CoreNetworkInterface
//
//  Created by 임현규 on 7/22/24.
//

import Foundation
import Moya

/// Moya Provider의  네트워크 요청을 async/await로 감싸기 위한 프로토콜
public protocol Providable<APIType> {
  associatedtype APIType: BaseTargetType
  
  /// swift concurrency로 네트워크 요청, Reponse 반환하는 메소드
  ///  - Parameters:
  ///   - api: BaseTargetType을 준수하는 API
  func reqeust(api: APIType) async throws -> Response
}
