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
          case .alertSetting:
            if let store = store.scope(
              state: \.alertSetting,
              action: \.alertSetting) {
              AlertSettingView(store: store)
            }
          case .accountSetting:
            if let store = store.scope(
              state: \.accountSetting,
              action: \.accountSetting) {
              AccountSettingView(store: store)
            }
          case .editProfile:
            if let store = store.scope(
              state: \.editProfile,
              action: \.editProfile
            ) {
              ProfileEditView(store: store)
            }
          }
        }
      }
    }
  }
}
