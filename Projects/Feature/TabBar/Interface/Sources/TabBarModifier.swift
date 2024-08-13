//
//  TabBarModifier.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/13/24.
//

import Foundation
import SwiftUI

public enum TabType: Hashable, CaseIterable {
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
  
  var image: Image.BottleImageSystem {
    switch self {
    case .sandBeach:
      return .icom(.sandBeach)
      
    case .bottleStorage:
      return .icom(.bottleStorage)
      
    case .myPage:
      return .icom(.myPage)
    }
  }
}

private struct TabBarModifier: ViewModifier {
  
  @State private var selectedTab: TabType
  
  private let action: (TabType) -> Void
  
  public init(
    selectedTab: TabType,
    action: @escaping (TabType) -> Void
  ) {
    self.selectedTab = selectedTab
    self.action = action
  }
  
  func body(content: Content) -> some View {
    ZStack {
      content
      VStack(spacing: 0) {
        Spacer()
        HStack(spacing: 0) {
          ForEach(TabType.allCases, id: \.title) { item in
            Spacer()
            VStack(spacing: 8) {
              BottleImageView(type: .local(bottleImageSystem: item.image))
                .foregroundStyle(to: selectedTab == item ? ColorToken.text(.selectSecondary) : ColorToken.icon(.primary))
              
              WantedSansStyleText(
                "\(item.title)",
                style: .caption,
                color: selectedTab == item ? .primary : .enableTertiary
              )
            }
            .offset(y: -9)
            .asThrottleButton {
              action(item)
            }
          }
          Spacer()
        }
        // TODO: - DesignSystem -> 디자인들 Contants 관리
        .frame(height: 106)
        .background {
          RoundedRectangle(cornerRadius: BottleRadiusType.xl.value)
            .fill(ColorToken.background(.secondary).color)
        }
      }
    }
    .ignoresSafeArea(.all, edges: [.bottom])
  }
}

public extension View {
  func setTabBar(selectedTab: TabType, action: @escaping (TabType) -> Void) -> some View {
    modifier(TabBarModifier(selectedTab: selectedTab, action: action))
  }
}
