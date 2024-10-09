//
//  FeatureGoodFeelingRootView.swift
//  FeatureGoodFeeling
//
//  Created by JongHoon on 10/6/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct GoodFeelingRootView: View {
  @Perception.Bindable private var store: StoreOf<GoodFeelingRootFeature>
  
  public init(store: StoreOf<GoodFeelingRootFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
        VStack(spacing: 0.0) {
          GoodFeelingView(store: store.scope(
            state: \.goodFeeling,
            action: \.goodFeeling
          ))
          Spacer()
            .frame(height: BottleConstants.bottomTabBarHeight.value)
        }
        .setTabBar(selectedTab: .goodFeeling) { selectedTab in
          store.send(.selectedTabDidChanged(selectedTab))
        }
      } destination: { store in
        WithPerceptionTracking {
          switch store.state {
          case .sentBottleDetail:
            if let store = store.scope(
              state: \.sentBottleDetail,
              action: \.sentBottleDetail
            ) {
              SentBottleDetailView(store: store)
            }
          }
        }
      }
    }
  }
}
