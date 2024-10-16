//
//  BottleArrivalDetailFeatureInterface.swift
//  FeatureBottleArrival
//
//  Created by JongHoon on 10/9/24.
//

import Foundation

import CoreToastInterface

import ComposableArchitecture

extension BottleArrivalDetailFeature {
  public init() {
    @Dependency(\.toastClient) var toastClient

    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .backButtonDidTapped:
        return .send(.delegate(.backButtonDidTapped))
        
      case let .showToast(message):
        toastClient.presentToast(message: message)
        return .none
        
      default:
        return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}

