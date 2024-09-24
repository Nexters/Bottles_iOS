//
//  AlertSettingFeatureInterface.swift
//  FeatureMyPageInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation

import DomainUserInterface

import ComposableArchitecture

@Reducer
public struct AlertSettingFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  // Desination
  @Reducer(state: .equatable)
  public enum Destination {
    case alert(AlertState<AlertSettingFeature.Action.Alert>)
  }
  
  @ObservableState
  public struct State: Equatable {
    var isAllowPushNotification: Bool
    public var isOnRandomBottleToggle: Bool
    public var isOnArrivalBottleToggle: Bool
    public var isOnPingPongToggle: Bool
    public var isOnMarketingToggle: Bool
    
    @Presents var destination: Destination.State?
    
    public init(
      isAllowPushNotification: Bool = false,
      isOnRandomBottleToggle: Bool = false,
      isOnArrivalBottleToggle: Bool = false,
      isOnPingPongToggle: Bool = false,
      isOnMarketingToggle: Bool = false
    ) {
      self.isAllowPushNotification = isAllowPushNotification
      self.isOnRandomBottleToggle = isOnRandomBottleToggle
      self.isOnArrivalBottleToggle = isOnArrivalBottleToggle
      self.isOnPingPongToggle = isOnPingPongToggle
      self.isOnMarketingToggle = isOnMarketingToggle
    }
  }
  
  public enum Action: BindableAction {
    case onLoad
    
    case randomBottleToggleDidFetched(isOn: Bool)
    case arrivalBottleToggleDidFetched(isOn: Bool)
    case pingpongToggleDidFetched(isOn: Bool)
    case marketingToggleDidFetched(isOn: Bool)
    case pushNotificationAlertDidRequired
    
    // UserAction
    case toggleDidChanged(alertState: UserAlertState)
    case backButtonDidTapped
    
    // ETC
    case binding(BindingAction<State>)
    case destination(PresentationAction<Destination.Action>)
    
    // Alert
    case alert(Alert)
    public enum Alert: Equatable {
      case confirmPushNotification
    }
  }
  
  enum ID: Hashable {
    case randomBottle
    case arrivalBottle
    case pingping
    case marketing
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
      .ifLet(\.$destination, action: \.destination)
  }
}
