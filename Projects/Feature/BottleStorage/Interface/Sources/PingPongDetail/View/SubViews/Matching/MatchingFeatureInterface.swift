//
//  MatchingFeatureInterface.swift
//  FeatureBottleStorage
//
//  Created by JongHoon on 8/11/24.
//

import Foundation

import DomainBottleInterface

import ComposableArchitecture

public enum MatchingStateType: Equatable {
  /// 상대방 결정 기다리는 중
  case waiting
  /// 매칭 성공
  case success
  /// 매칭 실패
  case failure
  /// 매칭 비활성화
  case none
}

@Reducer
public struct MatchingFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    public var matchingState: MatchingStateType
    public var kakaoTalkId: String?
    public var peerUserName: String?
    
    public init(
      matchingState: MatchingStateType = .none,
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
    case matchingStateDidFetched(matchResult: MatchResult, userName: String)
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

