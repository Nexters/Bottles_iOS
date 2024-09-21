//
//  AlertSettingFeatureInterface.swift
//  FeatureMyPageInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct AlertSettingFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    public var isOnRandomBottleToggle: Bool
    public var isOnArrivalBottleToggle: Bool
    public var isOnPingPongToggle: Bool
    public var isOnMarketingToggle: Bool
    
    public init(
      isOnRandomBottleToggle: Bool = false,
      isOnArrivalBottleToggle: Bool = false,
      isOnPingPongToggle: Bool = false,
      isOnMarketingToggle: Bool = false
    ) {
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
    
    case binding(BindingAction<State>)
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
  }
}
