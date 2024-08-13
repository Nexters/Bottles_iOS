//
//  TabBarModifier.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/13/24.
//

import Foundation
import SwiftUI

import SharedDesignSystem

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
