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
  
  private let leftButtonAction: (() -> Void)?
  private let rightButtonAction: (() -> Void)?
  
  init(
    leftView: (() -> L)? = nil,
    centerView: (() -> C)? = nil,
    rightView: (() -> R)? = nil,
    leftButtonAction: (() -> Void)? = nil,
    rightButtonAction: (() -> Void)? = nil
  ) {
    self.leftView = leftView
    self.centerView = centerView
    self.rightView = rightView
    self.leftButtonAction = leftButtonAction
    self.rightButtonAction = rightButtonAction
  }
  
  func body(content: Content) -> some View {
    content
      .navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          leftView?()
            .asThrottleButton(action: leftButtonAction ?? {})
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
            .asThrottleButton(action: rightButtonAction ?? {})
        }
      }
  }
}

// MARK: - View Modifier
public extension View {
  func setNavigationBar<L, C, R>(
    leftView: @escaping (() -> L),
    centerView: @escaping (() -> C),
    rightView: @escaping (() -> R),
    leftButtonAction: (() -> Void)? = nil,
    rightButtonAction: (() -> Void)? = nil
  ) -> some View where L: View, C: View, R: View {
    modifier(NavigationBarModifier(
      leftView: leftView,
      centerView: centerView,
      rightView: rightView,
      leftButtonAction: leftButtonAction,
      rightButtonAction: rightButtonAction)
    )
  }
  
  func setNavigationBar<L, C>(
    leftView: @escaping (() -> L),
    centerView: @escaping (() -> C),
    leftButtonAction: (() -> Void)? = nil
  ) -> some View where L: View, C: View {
    modifier(NavigationBarModifier(
      leftView: leftView,
      centerView: centerView,
      rightView: { EmptyView() },
      leftButtonAction: leftButtonAction,
      rightButtonAction: nil)
    )
  }
  
  func setNavigationBar<L, R>(
    leftView: @escaping (() -> L),
    rightView: @escaping (() -> R),
    leftButtonAction: (() -> Void)? = nil,
    rightButtonAction: (() -> Void)? = nil
  ) -> some View where L: View, R: View {
    modifier(NavigationBarModifier(
      leftView: leftView,
      centerView: { EmptyView() },
      rightView: rightView,
      leftButtonAction: leftButtonAction,
      rightButtonAction: rightButtonAction)
    )
  }
  
  func setNavigationBar<L>(
    leftView: @escaping (() -> L),
    leftButtonAction: (() -> Void)? = nil
  ) -> some View where L: View {
    modifier(NavigationBarModifier(
      leftView: leftView,
      centerView: { EmptyView() },
      rightView: { EmptyView() },
      leftButtonAction: leftButtonAction,
      rightButtonAction: nil)
    )
  }
}

// MARK: - NavigationBar Item

public extension View {
  func makeNaivgationleftButton() -> some View {
    BottleImageView(type: .local(bottleImageSystem: .icom(.leftArrow)))
      .foregroundStyle(to: ColorToken.icon(.primary))
  }
  
  func makeNavigationReportButton() -> some View {
      BottleImageView(type: .local(bottleImageSystem: .icom(.siren)))
        .foregroundStyle(to: ColorToken.icon(.primary))
  }
}
