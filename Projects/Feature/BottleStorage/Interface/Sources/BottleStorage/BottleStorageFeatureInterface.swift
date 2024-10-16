//
//  BottleStorageFeatureInterface.swift
//  FeatureBottleStorageExample
//
//  Created by JongHoon on 7/24/24.
//

import Foundation

import FeatureTabBarInterface
import DomainBottleInterface

import ComposableArchitecture

@Reducer
public struct BottleStorageFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    
    // 보틀 리스트
    var pingPongBottleList: [BottleStorageItem]
    
    var path = StackState<Path.State>()
    var isLoading: Bool = false
    
    public init() {
      self.pingPongBottleList = []
    }
  }
  
  public enum Action: BindableAction {
    // View Life Cycle
    case onAppear
    
    // 보틀 리스트
    case bottleStorageListFetched(BottleStorageList)
    case bottleStorageItemDidTapped(
      bottleID: Int,
      isRead: Bool,
      userName: String
    )
    case sandBeachButtonDidTapped
    case selectedTabDidChanged(selectedTab: TabType)
    case delegate(Delegate)
    // ETC.
    case path(StackAction<Path.State, Path.Action>)
    case binding(BindingAction<State>)
    
    public enum Delegate {
      case selectedTabDidChanged(selectedTab: TabType)
      case sandBeachButtonDidTapped
    }
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
      .forEach(\.path, action: \.path)
  }
}

extension PingPongLastStatus {
  var title: String {
    switch self {
    case .noAnswerFromBoth:
      return "문답을 시작해 주세요"
    case .answerFromOther:
      return "새로운 문답이 도착했어요"
    case .photoSharedByOther:
      return "사진이 도착했어요"
    case .contactSharedByOther:
      return "연락처가 도착했어요"
    case .answerFromMeOnly:
      return "문답을 보냈어요"
    case .photoSharedByMeOnly:
      return "사진을 공유했어요"
    case .contactSharedByMeOnly:
      return "연락처를 공유했어요"
    case .conversationStopped:
      return "대화가 중단됐어요"
    }
  }
}
