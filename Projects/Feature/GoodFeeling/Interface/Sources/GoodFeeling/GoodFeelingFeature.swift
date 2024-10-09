//
//  GoodFeelingFeatureInterface.swift
//  FeatureGoodFeelingInterface
//
//  Created by JongHoon on 10/6/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct GoodFeelingFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    public init() {
      
    }
  }
  
  public enum Action: BindableAction {
    case sentBottleTapped(url: String)
    
    case delegate(Delegate)
    public enum Delegate {
      case sentBottleTapped(url: String)
    }
    
    case binding(BindingAction<State>)
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    reducer
  }
}
