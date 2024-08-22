//
//  MainTabViewFeature.swift
//  Feature
//
//  Created by JongHoon on 7/22/24.
//

import Foundation

import FeatureBottleStorage
import FeatureBottleStorageInterface
import FeatureMyPage
import FeatureMyPageInterface
import FeatureSandBeach
import FeatureSandBeachInterface
import FeatureTabBarInterface

import ComposableArchitecture

@Reducer
public struct MainTabViewFeature {
  
  @ObservableState
  public struct State: Equatable {
    var sandBeachRoot: SandBeachRootFeature.State
    var bottleStorage: BottleStorageFeature.State
    var myPage: MyPageFeature.State
    var selectedTab: TabType
    var isLoading: Bool
    public init() {
      self.sandBeachRoot = .init()
      self.bottleStorage = .init()
      self.myPage = .init()
      self.selectedTab = .sandBeach
      self.isLoading = false
    }
  }
  
  public enum Action: BindableAction {
    case sandBeachRoot(SandBeachRootFeature.Action)
    case bottleStorage(BottleStorageFeature.Action)
    case myPage(MyPageFeature.Action)
    case selectedTabChanged(TabType)
    
    case binding(BindingAction<State>)
    
    case delegate(Delegate)
    
    public enum Delegate {
      case logoutDidCompleted
      case withdrawalDidCompleted
    }
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Scope(state: \.sandBeachRoot, action: \.sandBeachRoot) {
      SandBeachRootFeature()
    }
    Scope(state: \.bottleStorage, action: \.bottleStorage) {
      BottleStorageFeature()
    }
    Scope(state: \.myPage, action: \.myPage) {
      MyPageFeature()
    }
    Reduce(feature)
  }
  
  private func feature(
    state: inout State,
    action: Action
  ) -> EffectOf<Self> {
    switch action {
    case let .selectedTabChanged(tab):
      state.selectedTab = tab
      return .none
      
    // SandBeachRoot Delegate
    case let .sandBeachRoot(.delegate(delegate)):
      switch delegate {
      case .goToBottleStorageRequest:
        state.selectedTab = .bottleStorage
      case let .selectedTabDidChanged(selectedTab):
        state.selectedTab = selectedTab
      case .profileSetUpDidCompleted:
        return .send(.myPage(.userProfileUpdateDidRequest))
      }
      return .none
      
    // BottleStorage Delegate
    case let .bottleStorage(.delegate(delegate)):
      switch delegate {
      case let .selectedTabDidChanged(selectedTab):
        state.selectedTab = selectedTab
      }
      return .none
      
    // MyPage Delegate
    case let .myPage(.delegate(delegate)):
      switch delegate {
      case .logoutDidCompleted:
        return .send(.delegate(.logoutDidCompleted))
      case .withdrawalButtonDidTapped:
        state.isLoading = true
        return .none
      case .withdrawalDidCompleted:
        state.isLoading = false
        return .send(.delegate(.withdrawalDidCompleted))
      case let .selectedTabDidChanged(selectedTab):
        state.selectedTab = selectedTab
        return .none
      }
      
    default:
      return .none
    }
  }
}
