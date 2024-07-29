//
//  SandBeachFeature.swift
//  FeatureSandBeach
//
//  Created by JongHoon on 7/25/24.
//

import Foundation

import FeatureSandBeachInterface

import ComposableArchitecture

extension SandBeachFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
      case .writeButtonDidTapped:
        // TODO: - 자기소개 작성 Feature로 이동.
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
