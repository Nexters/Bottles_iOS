//
//  SandBeachRootView.swift
//  FeatureSandBeach
//
//  Created by 임현규 on 8/6/24.
//

import SwiftUI

import FeatureProfileSetupInterface
import FeatureBottleArrivalInterface
import CoreLoggerInterface
import FeatureTabBarInterface
import SharedDesignSystem

import ComposableArchitecture

public struct SandBeachRootView: View {
  @Perception.Bindable private var store: StoreOf<SandBeachRootFeature>
  
  public init(store: StoreOf<SandBeachRootFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
          SandBeachView(store: store.scope(state: \.sandBeach, action: \.sandBeach))
          .setTabBar(selectedTab: .sandBeach) { selectedTab in
            store.send(.selectedTabDidChanged(selectedTab: selectedTab))
          }
      } destination: { store in
        WithPerceptionTracking {
          switch store.state {
          case .IntroductionSetup:
            if let store = store.scope(
              state: \.IntroductionSetup,
              action: \.IntroductionSetup) {
              IntroductionSetupView(store: store)
            }
            
          case .ProfileImageUpload:
            if let store = store.scope(
              state: \.ProfileImageUpload,
              action: \.ProfileImageUpload) {
              ProfileImageUploadView(store: store)
            }
            
          case .BottleArrival:
            if let store = store.scope(
              state: \.BottleArrival,
              action: \.BottleArrival) {
              BottleArrivalView(store: store)
            }
            
          case .BottleArrivalDetail:
            if let store = store.scope(
              state: \.BottleArrivalDetail,
              action: \.BottleArrivalDetail
            ) {
              BottleArrivalDetailView(store: store)
            }
          }
        }
      }
    }
    .overlay {
      if store.isLoading {
        LoadingIndicator()
      }
    }
  }
}
