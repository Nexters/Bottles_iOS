//
//  MainTabViewFeature.swift
//  Feature
//
//  Created by JongHoon on 7/22/24.
//

import Foundation

import FeatureSandBeach
import FeatureSandBeachInterface
import FeatureGoodFeeling
import FeatureGoodFeelingInterface
import FeatureBottleStorage
import FeatureBottleStorageInterface
import FeatureMyPage
import FeatureMyPageInterface
import FeatureTabBarInterface

import ComposableArchitecture

@Reducer
public struct MainTabViewFeature {
  
  @ObservableState
  public struct State: Equatable {
    var sandBeachRoot: SandBeachRootFeature.State
    var goodFeelingRoot: GoodFeelingRootFeature.State
    var bottleStorage: BottleStorageFeature.State
    var myPageRoot: MyPageRootFeature.State
    var selectedTab: TabType
    var isLoading: Bool
    public init() {
      self.sandBeachRoot = .init()
      self.goodFeelingRoot = .init()
      self.bottleStorage = .init()
      self.myPageRoot = .init()
      self.selectedTab = .sandBeach
      self.isLoading = false
    }
  }
  
  public enum Action: BindableAction {
    case sandBeachRoot(SandBeachRootFeature.Action)
    case goodFeelingRoot(GoodFeelingRootFeature.Action)
    case bottleStorage(BottleStorageFeature.Action)
    case myPageRoot(MyPageRootFeature.Action)
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
    Scope(state: \.goodFeelingRoot, action: \.goodFeelingRoot) {
      GoodFeelingRootFeature()
    }
    Scope(state: \.bottleStorage, action: \.bottleStorage) {
      BottleStorageFeature()
    }
    Scope(state: \.myPageRoot, action: \.myPageRoot) {
      MyPageRootFeature()
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
        return .send(.myPageRoot(.userProfileUpdateDidRequest))
      }
      return .none
      
    // GoodFeeling Delegate
    case let .goodFeelingRoot(.delegate(delegate)):
      switch delegate {
      case let .selectedTabDidChanged(selectedTab):
        state.selectedTab = selectedTab
        return .none
      }
      
    // BottleStorage Delegate
    case let .bottleStorage(.delegate(delegate)):
      switch delegate {
      case let .selectedTabDidChanged(selectedTab):
        state.selectedTab = selectedTab
        return .none
      case .sandBeachButtonDidTapped:
        state.selectedTab = .sandBeach
        return .send(.sandBeachRoot(.sandBeach(.newBottleIslandDidTapped)))
      }
      
    // MyPage Delegate
    case let .myPageRoot(.delegate(delegate)):
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
