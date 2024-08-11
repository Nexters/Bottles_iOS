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
        let bottleList = try await networkManager.reqeust(api: .apiType(BottleAPI.fetchBottles), dto: BottleListResponseDTO.self)
        return (bottleList.randomBottles?.count ?? 0) + (bottleList.sentBottles?.count ?? 0)
      },
      fetchBottleStorageList: {
        let bottleStorageList = try await networkManager.reqeust(
          api: .apiType(BottleAPI.fetchBottleStorageList),
          dto: BottleStorageListResponseDTO.self
        ).toDomain()
        return bottleStorageList
      }
    )
  }
}

extension BottleClient {
  static public var previewValue = Self(
    fetchNewBottlesCount: { 5 }, 
    fetchBottleStorageList: {
      return BottleStorageList(
        activeBottles: [],
        doneBottles: []
      )
    }
  )
}

extension DependencyValues {
  public var bottleClient: BottleClient {
    get { self[BottleClient.self] }
    set { self[BottleClient.self] = newValue }
  }
}
