//
//  MyPageFeatureInterface.swift
//  FeatureMyPageInterface
//
//  Created by JongHoon on 7/24/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct MyPageFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    var isShowLoadingProgressView: Bool
    
    public init() {
      self.isShowLoadingProgressView = true
    }
  }
  
  public enum Action: BindableAction {
    // View Life Cycle
    case onAppear
    
    case webViewLoadingDidCompleted
    case presentToastDidRequired(message: String)
    case logOutButtonDidTapped
    case logOutDidCompleted
    case withdrawalButtonDidTapped
    case withdrawalDidCompleted
    
    // Delegate
    case delegate(Delegate)
    
    // ETC
    case binding(BindingAction<State>)
    
    public enum Delegate {
      case withdrawalDidCompleted
      case logoutDidCompleted
    }
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
