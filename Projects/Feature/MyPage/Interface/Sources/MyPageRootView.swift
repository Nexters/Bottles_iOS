//
//  MyPageRootView.swift
//  FeatureMyPageInterface
//
//  Created by 임현규 on 9/21/24.
//

import SwiftUI

import FeatureTabBarInterface

import ComposableArchitecture

public struct MyPageRootView: View {
  @Perception.Bindable private var store: StoreOf<MyPageRootFeature>
  
  public init(store: StoreOf<MyPageRootFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
        MyPageView(store: store.scope(state: \.myPage, action: \.myPage))
          .setTabBar(selectedTab: .myPage) { selectedTab in
            store.send(.selectedTabDidChanged(selectedTab: selectedTab))
          }
      } destination: { store in
        WithPerceptionTracking {
          switch store.state {
          case .AlertSetting:
            if let store = store.scope(
              state: \.AlertSetting,
              action: \.AlertSetting) {
              AlertSettingView(store: store)
            }
          }
        }
      }
    }
  }
}
