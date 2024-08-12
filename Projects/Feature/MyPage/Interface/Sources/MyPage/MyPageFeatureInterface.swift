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
    
    @Presents var destination: Destination.State?
    
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
    
    case delegate(Delegate)
    public enum Delegate {
      case withdrawalDidCompleted
      case logoutDidCompleted
    }
      
    case alert(Alert)
    public enum Alert: Equatable {
      case confirmLogOut
      case confirmWithdrawal
    }
  
    // ETC
    case destination(PresentationAction<Destination.Action>)
    case binding(BindingAction<State>)
  }
  
  public var body: some ReducerOf<Self> {
    reducer
      .ifLet(\.$destination, action: \.destination)
  }
}

extension MyPageFeature {
  @Reducer(state: .equatable)
  public enum Destination {
    case alert(AlertState<MyPageFeature.Action.Alert>)
  }
}
