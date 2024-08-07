//
//  BottleStorageFeatureInterface.swift
//  FeatureBottleStorageExample
//
//  Created by JongHoon on 7/24/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct BottleStorageFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    let bottleActiveStateTabs: [BottleActiveState]
    var selectedActiveStateTab: BottleActiveState
    
    public init() {
      self.bottleActiveStateTabs = BottleActiveState.allCases
      self.selectedActiveStateTab = .active
    }
  }
  
  public enum Action: BindableAction {
    case onAppear
    
    case bottleActiveStateTabButtonTapped(BottleActiveState)
    
    case binding(BindingAction<State>)
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}

public enum BottleActiveState: String, CaseIterable, Equatable {
  case active
  case done
  
  var title: String {
    switch self {
    case .active:
      return "대화 중"
    case .done:
      return "완료"
    }
  }
}
