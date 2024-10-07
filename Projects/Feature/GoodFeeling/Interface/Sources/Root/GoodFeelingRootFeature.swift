//
//  GoodFeelingRootFeature.swift
//  FeatureGoodFeelingInterface
//
//  Created by JongHoon on 10/6/24.
//

import Foundation

import FeatureTabBarInterface

import ComposableArchitecture

@Reducer
public struct GoodFeelingRootFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @Reducer(state: .equatable)
  public enum Path {
    
  }
  
  @ObservableState
  public struct State: Equatable {
    public var goodFeeling: GoodFeelingFeature.State
    
    var path = StackState<Path.State>()
    
    public init() {
      self.goodFeeling = .init()
    }
  }
  
  public enum Action {
    case selectedTabDidChanged(TabType)
    case goodFeeling(GoodFeelingFeature.Action)
    
    case path(StackAction<Path.State, Path.Action>)
    case delegate(Delegate)
    
    public enum Delegate {
      case selectedTabDidChanged(TabType)
    }
  }
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.goodFeeling, action: \.goodFeeling) {
      GoodFeelingFeature()
    }
    
    reducer
      .forEach(\.path, action: \.path)
  }
}

