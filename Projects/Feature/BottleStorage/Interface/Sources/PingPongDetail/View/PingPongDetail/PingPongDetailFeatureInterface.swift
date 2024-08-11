//
//  PingPongDetailFeatureInterface.swift
//  FeatureBottleStorageInterface
//
//  Created by JongHoon on 8/10/24.
//

import Foundation

import DomainBottleInterface

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
    var introduction: IntroductionFeature.State
    var questionAndAnswer: QuestionAndAnswerFeature.State
    var matching: MatchingFeature.State
    var selectedTab: PingPongDetailViewTabType
    
    public init(bottleID: Int) {
      self.introduction = .init()
      self.questionAndAnswer = .init()
      self.matching = .init()
      self.selectedTab = .introduction
      self.bottleID = bottleID
    }
  }
  
  public enum Action: BindableAction {
    // View Life Cycle
    case onLoad
    
    case pingPongDetailViewTabDidTapped(_: PingPongDetailViewTabType)
    
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

