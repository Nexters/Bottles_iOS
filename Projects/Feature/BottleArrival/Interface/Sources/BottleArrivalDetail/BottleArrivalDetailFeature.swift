//
//  BottleArrivalDetailFeature.swift
//  FeatureBottleArrival
//
//  Created by JongHoon on 10/9/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct BottleArrivalDetailFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    let bottleArrivalURL: String
    
    public init(bottleArrivalURL: String) {
      self.bottleArrivalURL = bottleArrivalURL
    }
  }
  
  public enum Action: BindableAction {
    case backButtonDidTapped
    case bottelDidAccepted
    case showToast(message: String)
    
    case delegate(Delegate)
    public enum Delegate {
      case backButtonDidTapped
    }
    
    case binding(BindingAction<State>)
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    reducer
  }
}
