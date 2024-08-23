//
//  PingPongDetailFeature.swift
//  FeatureBottleStorageInterface
//
//  Created by JongHoon on 8/10/24.
//

import Foundation

import CoreLoggerInterface
import FeatureReportInterface
import DomainBottle

import ComposableArchitecture

extension PingPongDetailFeature {
  public init() {
    @Dependency(\.bottleClient) var bottleClient
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onLoad:
        return fetchPingPong(state: &state)
        
      case let .pingPongDetailViewTabDidTapped(tab):
        state.selectedTab = tab
        return .none
        
      case let .pingPongDidFetched(pingPong):
        state.pingPong = pingPong
        return .none
        
      case .backButtonDidTapped:
        return .send(.delegate(.backButtonDidTapped))
        
      case .reportButtonDidTapped:
        let userId = state.pingPong?.userProfile.userId
        let imageURL = state.pingPong?.userProfile.userImageURL
        let userName = state.userName
        let userAge = state.pingPong?.userProfile.age
        let userReportProfile = UserReportProfile(
          imageURL: imageURL ?? "", userID: userId ?? -1, userName: userName, userAge: userAge ?? -1)
        return .send(.delegate(.reportButtonDidTapped(userReportProfile)))
          
      case let .introduction(.delegate(delegate)):
        switch delegate {
        case .popToRootDidRequired:
          return .send(.delegate(.popToRootDidRequired))
        }
        
      case let .questionAndAnswer(.delegate(delegate)):
        switch delegate {
        case .reloadPingPongRequired:
          return fetchPingPong(state: &state)
        case .popToRootDidRequired:
          return .send(.delegate(.popToRootDidRequired))
        }
        
      case let .matching(.delegate(delegate)):
        switch delegate {
        case .otherBottleButtonDidTapped:
          return .send(.delegate(.otherBottleButtonDidTapped))
        }
                     
      default:
        return .none
      }
    }
    
    self.init(reducer: reducer)
    
    func fetchPingPong(state: inout State) -> Effect<Action> {
      return .run { [bottleID = state.bottleID, isRead = state.isRead , userName = state.userName] send in
        async let pingPong = await bottleClient.fetchBottlePingPong(bottleID: bottleID)
        if !isRead { 
          async let _ = await bottleClient.readBottle(bottleID: bottleID)          
        }
        
        try await send(.pingPongDidFetched(pingPong))
        
        try await send(.introduction(.profileFetched(pingPong.userProfile)))
        try await send(.introduction(.isStoppedFetched(pingPong.isStopped)))
        try await send(.introduction(.introductionFetched(pingPong.introduction ?? [])))
        
        try await send(.questionAndAnswer(.pingPongDidFetched(pingPong)))
        try await send(.matching(.matchingStateDidFetched(
          matchResult: pingPong.matchResult,
          userName: userName,
          matchingPlace: pingPong.matchResult.meetingPlace,
          matchingPlaceImageURL: pingPong.matchResult.meetingPlaceImageURL
        )))
        try await send(.pingPongDidFetched(pingPong))
      } catch: { error, send in
        Log.error(error)
      }
    }
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
