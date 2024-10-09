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
    // View Life Cycle
    case onAppear
    case webViewLoadingDidCompleted
    case arrivalBottleTapped(url: String)
    case closeWebView
    case presentToastDidRequired(message: String)
    // Delegate
    case delegate(Delegate)
    
    public enum Delegate {
      case bottelDidAccepted
      case closeWebView
      case arrivalBottleTapped(url: String)
    }
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
