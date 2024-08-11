//
//  PingPongDetailFeature.swift
//  FeatureBottleStorageInterface
//
//  Created by JongHoon on 8/10/24.
//

import Foundation

import CoreLoggerInterface
import DomainBottle

import ComposableArchitecture

extension PingPongDetailFeature {
  public init() {
    @Dependency(\.bottleClient) var bottleClient
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onLoad:
        return .run { [bottleID = state.bottleID] send in
          let pingPong = try await bottleClient.fetchBottlePingPong(bottleID: bottleID)

        } catch: { error, send in
          Log.error(error)
        }
        
      case let .pingPongDetailViewTabDidTapped(tab):
        state.selectedTab = tab
        return .none
        
      case .binding, .introduction, .questionAndAnswer, .matching:
        return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}

public enum PingPongDetailViewTabType: CaseIterable {
  case introduction
  case questionAndAnswer
  case matching
  
  var title: String {
    switch self {
    case .introduction:
      return "소개"
      
    case .questionAndAnswer:
      return "가치관 문답"

    case .matching:
      return "매칭"
    }
  }
}

