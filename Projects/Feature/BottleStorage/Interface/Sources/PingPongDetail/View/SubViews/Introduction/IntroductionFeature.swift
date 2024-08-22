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
        state.destination = .alert(.init(
          title: { TextState("중단하기") },
          actions: {
            ButtonState(
              role: .destructive,
              action: .confirmStopTalk,
              label: { TextState("중단하기") })
          },
          message: { TextState("중단 시 모든 핑퐁 내용이 사라져요. 정말 중단하시겠어요?") }
        ))
        return .none
        
      case let .destination(.presented(.alert(alert))):
        switch alert {
        case .confirmStopTalk:
          return .run { [bottleID = state.bottleID] send in
            try await bottleClient.stopTalk(bottleID: bottleID)
            await send(.delegate(.popToRootDidRequired))
          }
        }
        
      case .refreshPingPongDidRequired:
        return .run { [bottleID = state.bottleID] send in
          let pingPong = try await bottleClient.fetchBottlePingPong(bottleID: bottleID)
          await send(.profileFetched(pingPong.userProfile))
          await send(.isStoppedFetched(pingPong.isStopped))
          await send(.introductionFetched(pingPong.introduction ?? []))
        }
        
      case .binding, .alert:
        return .none
        
      default:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
