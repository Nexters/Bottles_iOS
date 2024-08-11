//
//  NavigationBarModifier.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/11/24.
//

import Foundation
import SwiftUI

struct NavigationBarModifier<L, C, R>: ViewModifier where L: View, C: View, R: View {
  private let leftView: (() -> L)?
  private let centerView: (() -> C)?
  private let rightView: (() -> R)?
  
  init(
    leftView: (() -> L)? = nil,
    centerView: (() -> C)? = nil,
    rightView: (() -> R)? = nil
  ) {
    self.leftView = leftView
    self.centerView = centerView
    self.rightView = rightView
  }
  
  func body(content: Content) -> some View {
    content
      .navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          leftView?()
        }
      }
      .toolbar {
        ToolbarItem(placement: .principal) {
          centerView?()
        }
      }
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          rightView?()
        }
      }
  }
}

// MARK: - View Modifier
public extension View {
  func setNavigationBar<L, C, R>(
    leftView: @escaping (() -> L),
    centerView: @escaping (() -> C),
    rightView: @escaping (() -> R)
  ) -> some View where L: View, C: View, R: View {
    modifier(NavigationBarModifier(
      leftView: leftView,
      centerView: centerView,
      rightView: rightView)
    )
  }
  
  func setNavigationBar<L, C>(
    leftView: @escaping (() -> L),
    centerView: @escaping (() -> C)
  ) -> some View where L: View, C: View {
    modifier(NavigationBarModifier(
      leftView: leftView,
      centerView: centerView,
      rightView: { EmptyView() })
    )
  }
  
  func setNavigationBar<L, R>(
    leftView: @escaping (() -> L),
    rightView: @escaping (() -> R)
  ) -> some View where L: View, R: View {
    modifier(NavigationBarModifier(
      leftView: leftView,
      centerView: { EmptyView() },
      rightView: rightView)
    )
  }
  
  func setNavigationBar<L>(
    leftView: @escaping (() -> L)
  ) -> some View where L: View {
    modifier(NavigationBarModifier(
      leftView: leftView,
      centerView: { EmptyView() },
      rightView: { EmptyView() })
    )
  }
}

// MARK: - NavigationBar Item

public extension View {
  func makeNaivgationleftButton(action: (() -> Void)? = nil) -> some View {
    BottleImageView(type: .local(bottleImageSystem: .icom(.leftArrow)))
      .foregroundStyle(to: ColorToken.icon(.primary))
      .asThrottleButton(action: action ?? {})
  }
  
  func makeNavigationReportButton(action: (() -> Void)? = nil) -> some View {
      BottleImageView(type: .local(bottleImageSystem: .icom(.siren)))
        .foregroundStyle(to: ColorToken.icon(.primary))
        .asThrottleButton(action: action ?? {})
  }
}
