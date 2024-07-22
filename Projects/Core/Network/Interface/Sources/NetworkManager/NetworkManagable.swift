//
//  NetworkManagable.swift
//  CoreNetworkInterface
//
//  Created by 임현규 on 7/22/24.
//

import Foundation

public protocol NetworkManagable<APIType> {
  associatedtype APIType: BaseTargetType
  
  /// Swift Concurrency로 네트워크 요청하여 얻은 데이터 디코딩 후 반환하는 메소드
  /// - Parameters:
  ///   - api: BaseTargetType을 준수하는 API
  ///   - dto: 디코딩할 타입
  func reqeust<T: Decodable>(api: APIType, dto: T.Type) async throws -> T
  
  /// Swift Concurrency로 네트워크 요청하는 메소드 (요청만 하는 경우)
  /// - Parameters:
  ///   - api: BaseTargetType을 준수하는 API
  func reqeust(api: APIType) async throws
}
