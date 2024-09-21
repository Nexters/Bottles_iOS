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
    case toggleDidChanged(alertState: UserAlertState)
    case backButtonDidTapped
    
    case binding(BindingAction<State>)
  }
  
  enum ID: Hashable {
    case matcingToggle
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
  }
}
