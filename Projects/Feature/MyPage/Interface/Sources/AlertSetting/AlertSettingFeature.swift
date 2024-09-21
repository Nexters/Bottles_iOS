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

import DomainUser

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
        let isOn = state.isOnRandomBottleToggle
        return .send(.toggleDidChanged(
          alertState: .init(alertType: .randomBottle, enabled: isOn),
          id: .randomBottle))
        
      case .binding(\.isOnArrivalBottleToggle):
        let isOn = state.isOnArrivalBottleToggle
        return .send(.toggleDidChanged(
          alertState: .init(alertType: .arrivalBottle, enabled: isOn),
          id: .arrivalBottle))
        
      case .binding(\.isOnPingPongToggle):
        let isOn = state.isOnPingPongToggle
        return .send(.toggleDidChanged(
          alertState: .init(alertType: .pingpong, enabled: isOn),
          id: .pingping))
        
      case .binding(\.isOnMarketingToggle):
        let isOn = state.isOnMarketingToggle
        return .send(.toggleDidChanged(
          alertState: .init(alertType: .marketing, enabled: isOn),
          id: .marketing))
        
      case let .toggleDidChanged(alertState, id):
        updatePushNotificationAllowStatus(state: &state)
        
        if state.isAllowPushNotification {
          return .run { send in
            try await userClient.updateAlertState(alertState: alertState)
          }
          .debounce(
            id: id,
            for: 0.5,
            scheduler: DispatchQueue.main)
        } else {
          return .send(.pushNotificationAlertDidRequired)
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
