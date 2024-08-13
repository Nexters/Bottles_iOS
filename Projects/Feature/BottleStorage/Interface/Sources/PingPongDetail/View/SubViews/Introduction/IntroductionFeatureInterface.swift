//
//  IntroductionFeatureInterface.swift
//  FeatureBottleStorage
//
//  Created by JongHoon on 8/11/24.
//

import Foundation

import DomainBottleInterface

import ComposableArchitecture

@Reducer
public struct IntroductionFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    let bottleID: Int
    var userProfile: UserProfile?
    var isStopped: Bool?
    
    // 프로필
    var userName: String {
      userProfile?.userName ?? ""
    }
    var age: Int {
      userProfile?.age ?? 0
    }
    var userImageURL: String {
      userProfile?.userImageURL ?? ""
    }
    
    // 편지
    var introductions: [QuestionAndAnswer]?
    var introduction: String {
      if let introductions = introductions,
         !introductions.isEmpty {
        return introductions[0].answer
      } else {
        return ""
      }
    }
    
    // 정보
    var basicInfos: [String] {
      return [
        userProfile?.profileSelect?.job ?? "",
        userProfile?.profileSelect?.mbti ?? "",
        userProfile?.profileSelect?.region.city ?? "",
        String(userProfile?.profileSelect?.height ?? 0),
        userProfile?.profileSelect?.smoking ?? "",
        userProfile?.profileSelect?.alcohol ?? ""
      ]
    }
    var characterInfos: [String] {
      return userProfile?.profileSelect?.keyword ?? []
    }
    var hobyInfos: [String] {
      let interest = userProfile?.profileSelect?.interest
      return (interest?.culture ?? [])
        + (interest?.entertainment ?? [])
        + (interest?.etc ?? [])
        + (interest?.sports ?? [])
    }
    
    @Presents var destination: Destination.State?
    
    public init (bottleID: Int) { 
      self.bottleID = bottleID
    }
  }
  
  public enum Action: BindableAction {
    // View Life Cycle
    case onAppear
    
    case profileFetched(UserProfile)
    case isStoppedFetched(Bool)
    case introductionFetched([QuestionAndAnswer])
    case stopTaskButtonTapped
    case refreshPingPongDidRequired
    
    // ETC.
    case binding(BindingAction<State>)
    case destination(PresentationAction<Destination.Action>)
    
    case alert(Alert)
    public enum Alert: Equatable {
      case confirmStopTalk
    }
    
    case delegate(Delegate)
    
    public enum Delegate {
      case popToRootDidRequired
    }
  }
  
  public var body: some ReducerOf<Self> {
    reducer
      .ifLet(\.$destination, action: \.destination)
  }
}

// MARK: - Destination

extension IntroductionFeature {
  @Reducer(state: .equatable)
  public enum Destination {
    case alert(AlertState<IntroductionFeature.Action.Alert>)
  }
}

