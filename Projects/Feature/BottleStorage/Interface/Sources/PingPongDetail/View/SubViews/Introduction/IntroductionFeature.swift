//
//  IntroductionFeature.swift
//  FeatureBottleStorage
//
//  Created by JongHoon on 8/11/24.
//

import Foundation

import CoreLoggerInterface

import ComposableArchitecture

extension IntroductionFeature {
  public init() {
    @Dependency(\.bottleClient) var bottleClient
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
        
      case let .profileFetched(userProfile):
        state.userProfile = userProfile
        return .none
        
      case let .isStoppedFetched(isStopped):
        state.isStopped = isStopped
        return .none
        
      case let .introductionFetched(introductions):
        state.introductions = introductions
        return .none
        
      case .stopTaskButtonTapped:
        return .send(.delegate(.stopTaskButtonTapped))
        
      case .refreshPingPongDidRequired:
        return .run { [bottleID = state.bottleID] send in
          let pingPong = try await bottleClient.fetchBottlePingPong(bottleID: bottleID)
          await send(.profileFetched(pingPong.userProfile))
          await send(.isStoppedFetched(pingPong.isStopped))
          await send(.introductionFetched(pingPong.introduction ?? []))
        }
        
      case .binding:
        return .none
        
      default:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
