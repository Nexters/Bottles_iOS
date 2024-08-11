//
//  SolidButton.swift
//  DesignSystemExample
//
//  Created by 임현규 on 7/27/24.
//

import SwiftUI

public struct SolidButton: View {
  private let title: String
  private let sizeType: SizeType
  private let buttonType: ButtonType
  private let buttonApperance: ButtonAppearanceType
  private let action: () -> Void
  
  public init(
    title: String,
    sizeType: SizeType,
    buttonType: ButtonType,
    buttonApperance: ButtonAppearanceType = .solid,
    action: @escaping () -> Void
  ) {
    self.title = title
    self.sizeType = sizeType
    self.buttonType = buttonType
    self.buttonApperance = buttonApperance
    self.action = action
  }
  
  public var body: some View {
    solidStyleButton
    .buttonStyle(
      SolidButtonStyle(
        sizeType: sizeType,
        buttonApperance: buttonApperance
      )
    )
    .overlay(alignment: .leading) {
      image
        .padding(.leading, .md)
    }
  }
}

// MARK: - Public Extension

public extension SolidButton {
  enum SizeType {
    case extraSmall
    case small
    case medium
    case large
    case full
  }
}


// MARK: - Views

extension SolidButton {
  var titleText: some View {
    switch sizeType {
    case .extraSmall, .small:
      Text(title)
        .font(to: .wantedSans(.body))
      
    default:
      Text(title)
        .font(to: .wantedSans(.subTitle1))
    }
  }
  
  @ViewBuilder
  var solidStyleButton: some View {
    switch buttonType {
    case .normal:
      titleText.asButton(action: action)
    case .throttle:
      titleText.asThrottleButton(action: action)
    case .debounce:
      titleText.asDebounceButton(action: action)
    }
  }
  
  @ViewBuilder
  var image: some View {
    switch buttonApperance {
    case .kakao:
      BottleImageView(type: .local(bottleImageSystem: .icom(.kakaoLogo)))
    case .solid:
      EmptyView()
    }
  }
  
}
