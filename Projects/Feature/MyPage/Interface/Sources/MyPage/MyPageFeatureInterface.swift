//
//  MyPageFeatureInterface.swift
//  FeatureMyPageInterface
//
//  Created by JongHoon on 7/24/24.
//

import Foundation

import SharedDesignSystem
import DomainProfileInterface
import FeatureTabBarInterface

import ComposableArchitecture

@Reducer
public struct MyPageFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    var isShowLoadingProgressView: Bool
    public var keywordItem: [ClipItem]
    public var userInfo: UserInfo
    public var introduction: Introduction
    
    @Presents var destination: Destination.State?
    
    public init(
      keywordItem: [ClipItem] = []
    ) {
      self.isShowLoadingProgressView = true
      self.keywordItem = keywordItem
      self.userInfo = .init(userAge: -1, userImageURL: "", userName: "")
      self.introduction = .init(answer: "", question: "")
    }
  }
  
  public enum Action: BindableAction {
    // View Life Cycle
    case onLoad
    case userProfileDidFetched(UserProfile)
    case userProfileUpdateDidRequest
    case logOutButtonDidTapped
    case logOutDidCompleted
    case withdrawalButtonDidTapped
    case withdrawalDidCompleted
    case selectedTabDidChanged(TabType)
    case alertSettingListDidTapped
    case accountSettingListDidTapped
    
    case delegate(Delegate)
    
    public enum Delegate {
      case withdrawalButtonDidTapped
      case withdrawalDidCompleted
      case logoutDidCompleted
      case selectedTabDidChanged(TabType)
      case alertSettingListDidTapped
      case accountSettingListDidTapped
    }
      
    case alert(Alert)
    public enum Alert: Equatable {
      case confirmLogOut
      case confirmWithdrawal
    }
  
    // ETC
    case destination(PresentationAction<Destination.Action>)
    case binding(BindingAction<State>)
  }
  
  public var body: some ReducerOf<Self> {
    reducer
      .ifLet(\.$destination, action: \.destination)
  }
}

extension MyPageFeature {
  @Reducer(state: .equatable)
  public enum Destination {
    case alert(AlertState<MyPageFeature.Action.Alert>)
  }
}
