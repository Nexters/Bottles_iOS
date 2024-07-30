//
//  BottleClient.swift
//  DomainBottle
//
//  Created by 임현규 on 7/29/24.
//

import DomainBottleInterface
import CoreNetwork

import ComposableArchitecture
import Moya

extension BottleClient: DependencyKey {
  public static let liveValue: BottleClient = .live()
  
  private static func live() -> BottleClient {
    @Dependency(\.network) var networkManager
    
    return .init(
      fetchNewBottlesCount: {
        let newBottleList = try await networkManager.reqeust(api: .apiType(BottleAPI.fetchBottles), dto: BottleListResponseDTO.self)
        return newBottleList.bottles?.count
      }
    )
  }
}

extension BottleClient {
  static public var previewValue = Self(
    fetchNewBottlesCount: { 5 })
}

extension DependencyValues {
  public var bottleClient: BottleClient {
    get { self[BottleClient.self] }
    set { self[BottleClient.self] = newValue }
  }
}
