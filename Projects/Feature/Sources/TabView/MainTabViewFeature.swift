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

import ComposableArchitecture

@Reducer
public struct MainTabViewFeature {
  
  @ObservableState
  public struct State: Equatable {
    var sandBeachRoot: SandBeachRootFeature.State
    var bottleStorage: BottleStorageFeature.State
    var myPage: MyPageFeature.State
    var selectedTab: TabType
    
    public init() {
      self.sandBeachRoot = .init()
      self.bottleStorage = .init()
      self.myPage = .init()
      self.selectedTab = .sandBeach
    }
  }
  
  public enum Action: BindableAction {
    case sandBeachRoot(SandBeachRootFeature.Action)
    case bottleStorage(BottleStorageFeature.Action)
    case myPage(MyPageFeature.Action)
    case selectedTabChanged(TabType)
    case binding(BindingAction<State>)
  }
  
  public var body: some ReducerOf<Self> {
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
      
      return .none
      
    default:
      return .none
    }
  }
}
