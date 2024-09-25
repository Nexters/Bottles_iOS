//
//  AlertSettingFeature.swift
//  FeatureMyPageInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation
import Combine

import DomainUser
import DomainUserInterface

import CoreURLHandlerInterface
import CoreLoggerInterface

import ComposableArchitecture

extension AlertSettingFeature {
  public init() {
    @Dependency(\.userClient) var userClient
    @Dependency(\.dismiss) var dismiss
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onLoad:
        return Effect.publisher {
            userClient.pushNotificationAllowStatusPublisher
                .receive(on: DispatchQueue.main)
                .map { isAllow in
                    .pushNotificationAllowed(isAllow: isAllow)
                }
        }
        .cancellable(id: "PushNotificationPublisher", cancelInFlight: true)
        
      case .alertStateFetchDidRequest:
        updatePushNotificationAllowStatus(state: &state)

        return .run { [state = state] send in
          let isAllow = state.isAllowPushNotification
          let alertStateList = try await userClient.fetchAlertState()
          
          for alertState in alertStateList {
            let isOn = isAllow ? alertState.enabled : false
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
        
      case let .pushNotificationAllowed(isAllow):
        state.isAllowPushNotification = isAllow
        if isAllow {
          return .send(.alertStateFetchDidRequest)
        } else {
          return .merge(
            .send(.randomBottleToggleDidFetched(isOn: false)),
            .send(.pingpongToggleDidFetched(isOn: false)),
            .send(.arrivalBottleToggleDidFetched(isOn: false)),
            .send(.marketingToggleDidFetched(isOn: false))
          )
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
        updatePushNotificationAllowStatus(state: &state)
        if state.isAllowPushNotification {
          return .run { [isOn = state.isOnRandomBottleToggle] send in
            await send(.toggleDidChanged(alertState: .init(alertType: .randomBottle, enabled: isOn)))
          }
          .debounce(
            id: ID.randomBottle,
            for: 1.0,
            scheduler: DispatchQueue.main)
        } else {
          state.isOnRandomBottleToggle = false
          return .send(.pushNotificationAlertDidRequired)
        }
        
      case .binding(\.isOnArrivalBottleToggle):
        updatePushNotificationAllowStatus(state: &state)
        if state.isAllowPushNotification {
          return .run { [isOn = state.isOnArrivalBottleToggle] send in
            await send(.toggleDidChanged(alertState: .init(alertType: .arrivalBottle, enabled: isOn)))
          }
          .debounce(
            id: ID.arrivalBottle,
            for: 1.0,
            scheduler: DispatchQueue.main)
        } else {
          state.isOnArrivalBottleToggle = false
          return .send(.pushNotificationAlertDidRequired)
        }
        
      case .binding(\.isOnPingPongToggle):
        updatePushNotificationAllowStatus(state: &state)
        if state.isAllowPushNotification {
          return .run { [isOn = state.isOnPingPongToggle] send in
            await send(.toggleDidChanged(alertState: .init(alertType: .pingpong, enabled: isOn)))
          }
          .debounce(
            id: ID.pingping,
            for: 1.0,
            scheduler: DispatchQueue.main)
        } else {
          state.isOnPingPongToggle = false
          return .send(.pushNotificationAlertDidRequired)
        }
      case .binding(\.isOnMarketingToggle):
        updatePushNotificationAllowStatus(state: &state)
        if state.isAllowPushNotification {
          return .run { [isOn = state.isOnMarketingToggle] send in
            await send(.toggleDidChanged(alertState: .init(alertType: .marketing, enabled: isOn)))
          }
          .debounce(
            id: ID.marketing,
            for: 1.0,
            scheduler: DispatchQueue.main)
        } else {
          state.isOnMarketingToggle = false
          return .send(.pushNotificationAlertDidRequired)
        }
        
      case let .toggleDidChanged(alertState):
        return .run { send in
          try await userClient.updateAlertState(alertState: alertState)
        }

        
      case .pushNotificationAlertDidRequired:
        state.destination = .alert(.init(
          title: { TextState("알림 권한 안내")},
          actions: { ButtonState(
            role: .destructive,
            action: .confirmPushNotification,
            label: { TextState("설정하러 가기") }) },
          message: { TextState("설정 > '보틀' > 알림에서 알림을 허용해주세요.")}))

        return .none
        
      case let .destination(.presented(.alert(alert))):
        switch alert {
        case .confirmPushNotification:
          URLHandler.shared.openURL(urlType: .setting)
          return .none
        }
        
      default:
        return .none
      }
      
      func updatePushNotificationAllowStatus(state: inout State) {
        let isAllow = userClient.fetchPushNotificationAllowStatus()
        state.isAllowPushNotification = isAllow
      }
    }
    
    self.init(reducer: reducer)
  }
}
