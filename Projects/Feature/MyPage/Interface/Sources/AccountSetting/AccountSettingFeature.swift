//
//  AccountSettingFeature.swift
//  FeatureMyPageInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation

import DomainUser
import DomainUserInterface

import ComposableArchitecture

extension AccountSettingFeature {
  public init() {
    @Dependency(\.userClient) var userClient
    @Dependency(\.dismiss) var dismiss
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onLoad:
        return .none
      
      case let .matchingToggleDidFetched(isOn):
        state.isOnMatchingToggle = isOn
        return .none
        
      case .backButtonDidTapped:
        return .run { _ in
          await dismiss()
        }
        
      case .binding(\.isOnMatchingToggle):
        return .run { [isOn = state.isOnMatchingToggle] send in
          await send(.toggleDidChanged(alertState: .init(alertType: .randomBottle, enabled: isOn)))
        }
        .debounce(
          id: ID.matcingToggle,
          for: 1.0,
          scheduler: DispatchQueue.main)
        
      case let .toggleDidChanged(alertState):
        return .run { send in
          try await userClient.updateAlertState(alertState: alertState)
        }
        
      default:
        return .none
      }
      
      
    }
    self.init(reducer: reducer)
  }
}
