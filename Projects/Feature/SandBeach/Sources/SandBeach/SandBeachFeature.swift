//
//  SandBeachFeature.swift
//  FeatureSandBeach
//
//  Created by JongHoon on 7/25/24.
//

import Foundation

import FeatureSandBeachInterface
import DomainProfile
import DomainBottle
import CoreLoggerInterface

import ComposableArchitecture

extension SandBeachFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
      case .writeButtonDidTapped:
        Log.debug("writeButtonDidTapped")
        return .none
      case .newBottlePopupDidTapped:
        Log.debug("newBottlePopupDidTapped")
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
