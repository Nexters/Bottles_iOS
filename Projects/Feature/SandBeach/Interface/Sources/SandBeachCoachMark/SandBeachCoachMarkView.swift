//
//  SandBeachCoachMarkView.swift
//  FeatureSandBeachInterface
//
//  Created by 임현규 on 10/28/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct SandBeachCoachMarkView: View {
  @Perception.Bindable private var store: StoreOf<SandBeachCoachMarkFeature>
  
  public init(store: StoreOf<SandBeachCoachMarkFeature>) {
    self.store = store
  }
  
  public var body: some View {
    VStack(spacing: 0.0) {
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .contentShape(Rectangle())
    .asButton {
      store.send(.coachMarkDidTapped)
    }
    .background(Color.black.opacity(0.7))
  }
}
