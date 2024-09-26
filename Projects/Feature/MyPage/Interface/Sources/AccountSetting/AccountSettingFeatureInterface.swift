//
//  AccountSettingFeatureInterface.swift
//  FeatureMyPageInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation

import DomainUserInterface

import ComposableArchitecture

@Reducer
public struct AccountSettingFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    public var isOnMatchingToggle: Bool
    @Presents var destination: Destination.State?

    public init(
      isOnMatchingToggle: Bool = false
    ) {
      self.isOnMatchingToggle = isOnMatchingToggle
    }
  }
  
  public enum Action: BindableAction {
    case onLoad
    
    case matchingToggleDidFetched(isOn: Bool)
    
    // UserAction
    case matchingToggleDidChanged(isOn: Bool)
    case backButtonDidTapped
    case logoutButtonDidTapped
    case withdrawalButtonDidTapped
    case logoutDidCompleted
    case withdrawalDidCompleted
    
    // binding
    case binding(BindingAction<State>)
    
    // alert
    case alert(Alert)
    public enum Alert: Equatable {
      case confirmLogOut
      case confirmWithdrawal
      case dismiss
    }
    
    // delegate
    case delegate(Delegate)
    
    public enum Delegate {
      case logoutDidCompleted
      case withdrawalDidCompleted
      case withdrawalButtonDidTapped
    }
    
    case destination(PresentationAction<Destination.Action>)
  }
  
  @Reducer(state: .equatable)
  public enum Destination {
    case alert(AlertState<AccountSettingFeature.Action.Alert>)
  }
  
  enum ID: Hashable {
    case matcingToggle
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
      .ifLet(\.$destination, action: \.destination)
  }
}
