//
//  AlertSettingFeature.swift
//  FeatureMyPageInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation

import DomainUser
import DomainUserInterface

import ComposableArchitecture

extension AlertSettingFeature {
  public init() {
    @Dependency(\.userClient) var userClient
    @Dependency(\.dismiss) var dismiss
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onLoad:
        return .run { send in
          let alertStateList = try await userClient.fetchAlertState()
          
          for alertState in alertStateList {
            let isOn = alertState.enabled
            switch alertState.alertType {
            case .randomBottle:
              await send(.randomBottleToggleDidFetched(isOn: isOn))
            case .arrivalBottle:
              await send(.arrivalBottleToggleDidFetched(isOn: isOn))
            case .pingpong:
              await send(.pingpongToggleDidFetched(isOn: isOn))
            case .marketing:
              await send(.marketingToggleDidFetched(isOn: isOn))
            default:
              break
            }
          }
        }
      
      case let .randomBottleToggleDidFetched(isOn):
        state.isOnRandomBottleToggle = isOn
        return .none
        
      case let .arrivalBottleToggleDidFetched(isOn):
        state.isOnArrivalBottleToggle = isOn
        return .none
        
      case let .pingpongToggleDidFetched(isOn):
        state.isOnPingPongToggle = isOn
        return .none
        
      case let .marketingToggleDidFetched(isOn):
        state.isOnMarketingToggle = isOn
        return .none
        
      case .backButtonDidTapped:
        return .run { _ in
          await dismiss()
        }
        
      case .binding(\.isOnRandomBottleToggle):
        return .run { [isOn = state.isOnRandomBottleToggle] send in
          await send(.toggleDidChanged(alertState: .init(alertType: .randomBottle, enabled: isOn)))
        }
        .debounce(
          id: ID.randomBottle,
          for: 1.0,
          scheduler: DispatchQueue.main)
        
      case .binding(\.isOnArrivalBottleToggle):
        return .run { [isOn = state.isOnArrivalBottleToggle] send in
          await send(.toggleDidChanged(alertState: .init(alertType: .arrivalBottle, enabled: isOn)))
        }
        .debounce(
          id: ID.arrivalBottle,
          for: 1.0,
          scheduler: DispatchQueue.main)
        
      case .binding(\.isOnPingPongToggle):
        return .run { [isOn = state.isOnPingPongToggle] send in
          await send(.toggleDidChanged(alertState: .init(alertType: .pingpong, enabled: isOn)))
        }
        .debounce(
          id: ID.pingping,
          for: 1.0,
          scheduler: DispatchQueue.main)
        
      case .binding(\.isOnMarketingToggle):
        return .run { [isOn = state.isOnMarketingToggle] send in
          await send(.toggleDidChanged(alertState: .init(alertType: .marketing, enabled: isOn)))
        }        
        .debounce(
          id: ID.marketing,
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
