//
//  MatchingView.swift
//  FeatureBottleStorage
//
//  Created by JongHoon on 8/11/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct MatchingView: View {
  @Perception.Bindable private var store: StoreOf<MatchingFeature>
  
  public init(store: StoreOf<MatchingFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      ScrollView {
        VStack(alignment: .leading, spacing: 0.0) {
          Text("Matching")
        }
        .frame(maxHeight: .infinity)
      }
    }
  }
}
