//
//  MyPageRootFeature.swift
//  FeatureMyPageInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation

import FeatureTabBarInterface

import ComposableArchitecture

@Reducer
public struct MyPageRootFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @Reducer(state: .equatable)
  public enum Path {
    case alertSetting(AlertSettingFeature)
    case accountSetting(AccountSettingFeature)
    case editProfile(EditProfileFeature)
  }

  @ObservableState
  public struct State: Equatable {
    var path = StackState<Path.State>()
    public var myPage: MyPageFeature.State
    
    public init(
      path: StackState<Path.State> = StackState<Path.State>(),
      myPage: MyPageFeature.State = .init()
    ) {
      self.path = path
      self.myPage = myPage
    }
  }
  
  public enum Action {
    case path(StackAction<Path.State, Path.Action>)
    case myPage(MyPageFeature.Action)
    case delegate(Delegate)
    case selectedTabDidChanged(selectedTab: TabType)
    case userProfileUpdateDidRequest

    public enum Delegate {
      case withdrawalButtonDidTapped
      case withdrawalDidCompleted
      case logoutDidCompleted
      case selectedTabDidChanged(TabType)
    }
  }
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.myPage, action: \.myPage) {
      MyPageFeature()
    }
    
    reducer
      .forEach(\.path, action: \.path)
  }
}
