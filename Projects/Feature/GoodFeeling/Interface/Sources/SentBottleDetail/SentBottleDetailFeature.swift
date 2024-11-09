//
//  SentBottleDetailFeature.swift
//  FeatureGoodFeeling
//
//  Created by JongHoon on 10/9/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct SentBottleDetailFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    var isLoading: Bool
    let sentBottleDetailURL: String
    
    public init(sentBottleDetailURL: String) {
      self.isLoading = true
      self.sentBottleDetailURL = sentBottleDetailURL
    }
  }
  
  public enum Action: BindableAction {
    case webViewLoadingDidCompleted
    case backButtonDidTapped
    case bottelDidAccepted
    
    case configureIsLoading(_: Bool)
    case showToast(message: String)
    
    case delegate(Delegate)
    public enum Delegate {
      case backButtonDidTapped
      case bottelDidAccepted
    }
    
    case binding(BindingAction<State>)
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    reducer
  }
}

