//
//  PingPongDetailFeatureInterface.swift
//  FeatureBottleStorageInterface
//
//  Created by JongHoon on 8/10/24.
//

import Foundation

import DomainBottleInterface
import FeatureReportInterface

import ComposableArchitecture

@Reducer
public struct PingPongDetailFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    let bottleID: Int
    let isRead: Bool
    var userName: String
    var pingPong: BottlePingPong?
    var isStopped: Bool {
      return pingPong?.isStopped == true || pingPong?.isStopped == nil
    }
    var isMatchingTabDisabled: Bool {
      guard let matchStatus = pingPong?.matchResult.matchStatus
      else {
        return false
      }
      
      return matchStatus == .disabled || matchStatus == .requireSelect
    }
    
    var introduction: IntroductionFeature.State
    var questionAndAnswer: QuestionAndAnswerFeature.State
    var matching: MatchingFeature.State
    var selectedTab: PingPongDetailViewTabType
    
    public init(
      bottleID: Int,
      isRead: Bool,
      userName: String
    ) {
      self.introduction = .init(bottleID: bottleID)
      self.isRead = isRead
      self.questionAndAnswer = .init(bottleID: bottleID)
      self.matching = .init(matchingState: .disabled)
      self.selectedTab = .introduction
      self.bottleID = bottleID
      self.userName = userName
    }
  }
  
  public enum Action: BindableAction {
    // View Life Cycle
    case onLoad
    
    // User Action
    case pingPongDetailViewTabDidTapped(_: PingPongDetailViewTabType)
    case pingPongDidFetched(_: BottlePingPong)
    case backButtonDidTapped
    case reportButtonDidTapped
    
    
    // Delegate
    case delegate(Delegate)
    public enum Delegate {
      case backButtonDidTapped
      case reportButtonDidTapped(UserReportProfile)
      case otherBottleButtonDidTapped
      case popToRootDidRequired
    }
    
    // ETC.
    case introduction(IntroductionFeature.Action)
    case questionAndAnswer(QuestionAndAnswerFeature.Action)
    case matching(MatchingFeature.Action)
    case binding(BindingAction<State>)
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Scope(state: \.introduction, action: \.introduction) {
      IntroductionFeature()
    }
    Scope(state: \.questionAndAnswer, action: \.questionAndAnswer) {
      QuestionAndAnswerFeature()
    }
    Scope(state: \.matching, action: \.matching) {
      MatchingFeature()
    }
    reducer
  }
}

