//
//  AlertSettingFeature.swift
//  FeatureMyPageInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation

import DomainUser

import ComposableArchitecture

extension AlertSettingFeature {
  public init() {
    @Dependency(\.userClient) var userClient
    
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
            case .ArrivalBottle:
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
        
      default:
        return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
