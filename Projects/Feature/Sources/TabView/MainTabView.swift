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
            .tabItem {
              VStack(spacing: 8.0) {
                BottleImageView(type: .local(bottleImageSystem: .icom(.sandBeach)))
                .foregroundStyle(to: ColorToken.icon(.primary))
                
                WantedSansStyleText(
                  "\(TabType.sandBeach.title)",
                  style: .caption,
                  color: .enableTertiary
                )
              }
            }
            .tag(TabType.sandBeach)
          
          BottleStorageView(store: store.scope(state: \.bottleStorage, action: \.bottleStorage))
            .tabItem {
              VStack(spacing: 8.0) {
                BottleImageView(type: .local(bottleImageSystem: .icom(.bottleStorage)))
                  .foregroundStyle(to: ColorToken.icon(.primary))
                
                WantedSansStyleText(
                  "\(TabType.bottleStorage.title)",
                  style: .caption,
                  color: .enableTertiary
                )
              }
            }
            .tag(TabType.bottleStorage)
          
          MyPageView(store: store.scope(state: \.myPage, action: \.myPage))
            .tabItem {
              VStack(spacing: 8.0) {
                BottleImageView(type: .local(bottleImageSystem: .icom(.myPage)))
                  .foregroundStyle(to: ColorToken.icon(.primary))
                WantedSansStyleText(
                  "\(TabType.myPage.title)",
                  style: .caption,
                  color: .enableTertiary
                )
              }
            }
            .tag(TabType.myPage)
        }
        .accentColor(ColorToken.text(.selectSecondary).color)
      }
    }
  }
}

extension UITabBarController {
  open override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .white
    appearance.backgroundColor = .white

    tabBar.standardAppearance = appearance
    tabBar.scrollEdgeAppearance = tabBar.standardAppearance
    tabBar.layer.masksToBounds = true
    tabBar.layer.cornerRadius = 24.0
    tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    var tabFrame = self.tabBar.frame
    tabFrame.size.height = 94.0
    tabFrame.origin.y = self.view.frame.size.height - 94.0
    tabBar.frame = tabFrame
  }
}
