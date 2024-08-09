//
//  BottleStorageFeatureInterface.swift
//  FeatureBottleStorageExample
//
//  Created by JongHoon on 7/24/24.
//

import Foundation

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
    // 보틀 상태 선택 탭(대화 중, 완료)
    let bottleActiveStateTabs: [BottleActiveState]
    var selectedActiveStateTab: BottleActiveState
    var currentSelectedBottles: [BottleStorageItem] {
      switch selectedActiveStateTab {
      case .active:
        return activeBottleList ?? []
      case .done:
        return doneBottlsList ?? []
      }
    }
    
    // 보틀 리스트
    var activeBottleList: [BottleStorageItem]?
    var doneBottlsList: [BottleStorageItem]?
    
    public init() {
      self.bottleActiveStateTabs = BottleActiveState.allCases
      self.selectedActiveStateTab = .active
    }
  }
  
  public enum Action: BindableAction {
    // View Life Cycle
    case onAppear
    
    // 보틀 상태 선택 탭(대화 중, 완료)
    case bottleActiveStateTabButtonTapped(BottleActiveState)
    
    // 보틀 리스트
    case bottleStorageListFetched(BottleStorageList)
    
    // ETC.
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
