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

import ComposableArchitecture

public struct MainTabView: View {
  @Bindable private var store: StoreOf<MainTabViewFeature>

  public init(store: StoreOf<MainTabViewFeature>) {
    self.store = store
  }
  
  public var body: some View {
    EmptyView()
    
    WithViewStore(store, observe: \.selectedTab) { viewStore in
      TabView(selection: $store.selectedTab.sending(\.selectedTabChanged)) {
        SandBeachView(store: store.scope(state: \.sandBeach, action: \.sandBeach))
          .tabItem {
            VStack(spacing: 8.0) {
              Image(systemName: "house.fill")
              
              Text("\(TabType.sandBeach.title)")
            }
          }
          .tag(TabType.sandBeach)
        
        BottleStorageView(store: store.scope(state: \.bottleStorage, action: \.bottleStorage))
          .tabItem {
            VStack(spacing: 8.0) {
              Image(systemName: "house.fill")
              
              Text("\(TabType.bottleStorage.title)")
            }
          }
          .tag(TabType.bottleStorage)
        
        MyPageView(store: store.scope(state: \.myPage, action: \.myPage))
          .tabItem {
            VStack(spacing: 8.0) {
              Image(systemName: "house.fill")
              
              Text("\(TabType.myPage.title)")
            }
          }
          .tag(TabType.myPage)
      }
    }
  }
}

public enum TabType: Hashable {
  case sandBeach
  case bottleStorage
  case myPage
  
  var title: String {
    switch self {
    case .sandBeach:
      return "모래사장"
      
    case .bottleStorage:
      return "보틀 보관함"
      
    case .myPage:
      return "마이페이지"
    }
  }
}

extension UITabBarController {
  open override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    tabBar.layer.masksToBounds = true
    tabBar.layer.cornerRadius = 24.0
    tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    var tabFrame = self.tabBar.frame
    tabFrame.size.height = 94.0  // 원하는 높이로 설정
    tabFrame.origin.y = self.view.frame.size.height - 94.0  // 높이에 맞게 위치 조정
    tabBar.frame = tabFrame
    
    if let shadowView = view.subviews.first(where: { $0.accessibilityIdentifier == "TabBarShadow" }) {
      shadowView.frame = tabBar.frame
    } else {
      let shadowView = UIView(frame: .zero)
      shadowView.frame = tabBar.frame
      shadowView.accessibilityIdentifier = "TabBarShadow"
      shadowView.backgroundColor = UIColor.white
      shadowView.layer.cornerRadius = tabBar.layer.cornerRadius
      shadowView.layer.maskedCorners = tabBar.layer.maskedCorners
      shadowView.layer.masksToBounds = false
      shadowView.layer.shadowColor = Color.black.cgColor
      shadowView.layer.shadowOffset = CGSize(width: 0.0, height: -8.0)
      shadowView.layer.shadowOpacity = 0.05
      shadowView.layer.shadowRadius = 24.0
      view.addSubview(shadowView)
      view.bringSubviewToFront(tabBar)
    }
  }
}
