//
//  BottleArrivalFeatureInterface.swift
//  FeatureBottleArrivalInterface
//
//  Created by 임현규 on 8/11/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct BottleArrivalFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  @ObservableState
  public struct State: Equatable {
    var isLoading: Bool
    
    public init() {
      self.isLoading = true
    }
  }
  
  public enum Action {
    case onAppear
    case webViewLoadingDidCompleted
    case bottelDidAccepted
    case closeWebView
    case delegate(Delegate)
    
    public enum Delegate {
      case bottelDidAccepted
      case closeWebView
    }
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
