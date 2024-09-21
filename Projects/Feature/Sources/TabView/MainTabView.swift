//
//  MainTabView.swift
//  AppManifests
//
//  Created by JongHoon on 7/22/24.
//

import SwiftUI

import FeatureBottleStorageInterface
import FeatureMyPageInterface
import FeatureSandBeachInterface
import FeatureTabBarInterface
import SharedDesignSystem

import ComposableArchitecture

public struct MainTabView: View {
  @Perception.Bindable private var store: StoreOf<MainTabViewFeature>
  
  public init(store: StoreOf<MainTabViewFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(store, observe: \.selectedTab) { viewStore in
      WithPerceptionTracking {
        TabView(selection: $store.selectedTab.sending(\.selectedTabChanged)) {
          SandBeachRootView(store: store.scope(state: \.sandBeachRoot, action: \.sandBeachRoot))
            .tag(TabType.sandBeach)
            .toolbar(.hidden, for: .tabBar)
          
          BottleStorageView(store: store.scope(state: \.bottleStorage, action: \.bottleStorage))
            .tag(TabType.bottleStorage)
            .toolbar(.hidden, for: .tabBar)
          
          MyPageRootView(store: store.scope(state: \.myPageRoot, action: \.myPageRoot))
            .tag(TabType.myPage)
            .toolbar(.hidden, for: .tabBar)
        }
        .overlay {
          if store.isLoading {
            LoadingIndicator()
          }
        }
        .accentColor(ColorToken.text(.selectSecondary).color)
      }
    }
  }
}

extension UITabBarController {
  open override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    tabBar.isHidden = true
  }
}
