//
//  MatchingFeatureInterface.swift
//  FeatureBottleStorage
//
//  Created by JongHoon on 8/11/24.
//

import Foundation

import DomainBottleInterface

import ComposableArchitecture

@Reducer
public struct MatchingFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    public var matchingState: PingPongMatchStatus
    public var kakaoTalkId: String?
    public var peerUserName: String?
    
    public init(
      matchingState: PingPongMatchStatus,
      kakaoTalkId: String? = nil,
      peerUserName: String? = nil
    ) {
      self.matchingState = matchingState
      self.kakaoTalkId = kakaoTalkId
      self.peerUserName = peerUserName
    }
  }
  
  public enum Action: BindableAction {
    // View Life Cycle
    case onAppear
    
    // User Action
    case matchingStateDidFetched(
      matchResult: MatchResult,
      userName: String
    )
    case copyButtonDidTapped
    case otherBottleButtonDidTapped
    
    // Delegate
    case delegate(Delegate)
    public enum Delegate {
      case otherBottleButtonDidTapped
    }
    
    // ETC.
    case binding(BindingAction<State>)
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
