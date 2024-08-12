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
      },
      fetchBottlePingPong: { id in
        let bottlePingPong = try await networkManager.reqeust(
          api: .apiType(BottleAPI.fetchBottlePingPong(bottleID: id)),
          dto: BottlePingPongResponseDTO.self
        ).toDomain()
        return bottlePingPong
      }, 
      registerLetterAnswer: { bottleID, order, answer in
        try await networkManager.reqeust(api: .apiType(BottleAPI.registerLetterAnswer(
          bottleID: bottleID,
          registerLetterAnswerRequestDTO: .init(answer: answer, order: order)
        )))
      }, 
      shareImage: { bottleID, willShare in
        try await networkManager.reqeust(api: .apiType(BottleAPI.imageShare(
          bottleID: bottleID,
          imageShareRequestDTO: .init(willShare: willShare)
        )))
      },
      finalSelect: { bottleID, willMatch in
        try await networkManager.reqeust(api: .apiType(BottleAPI.finalSelect(
          bottleID: bottleID,
          finalSelectRequestDTO: .init(wilMatch: willMatch)
        )))
      }
    )
  }
}

extension DependencyValues {
  public var bottleClient: BottleClient {
    get { self[BottleClient.self] }
    set { self[BottleClient.self] = newValue }
  }
}
