//
//  SolidButtonStyle.swift
//  DesignSystemExample
//
//  Created by 임현규 on 7/27/24.
//

import SwiftUI

public enum ButtonAppearanceType {
  case solid
  case kakao
  case generalSignIn
}

struct SolidButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled: Bool
  private let sizeType: SolidButton.SizeType
  private let buttonApperance: ButtonAppearanceType
  
  public init(
    sizeType: SolidButton.SizeType,
    buttonApperance: ButtonAppearanceType = .solid
  ) {
    self.sizeType = sizeType
    self.buttonApperance = buttonApperance
  }
  
  func makeBody(configuration: Configuration) -> some View {
    let buttonState = makeButtonState(configuration)
    
    return configuration.label
      .padding(.horizontal, .sm)
      .frame(height: height)
      .frame(maxWidth: width)
      .foregroundStyle(foregroundColor(buttonState))
      .background {
        RoundedRectangle(cornerRadius: cornerRadius.value)
          .fill(backgroundColor(buttonState))
      }
  }
}

// MARK: - Private Extension

private extension SolidButtonStyle {
  var height: CGFloat {
    switch sizeType {
    case .extraSmall: return 36
    case .small:      return 36
    case .medium:     return 56
    case .large:      return 64
    case .full:       return 64
    }
  }
  
  var width: CGFloat? {
    switch sizeType {
    case .extraSmall: return nil
    case .small:      return .infinity
    case .medium:     return .infinity
    case .large:      return .infinity
    case .full:       return .infinity
    }
  }
  
  var cornerRadius: BottleRadiusType {
    switch sizeType {
    case .extraSmall: return .xs
    case .small:      return .sm
    case .medium:     return .md
    case .large:      return .md
    case .full:       return .md
    }
  }

  func makeButtonState(_ configuration: Configuration) -> ButtonStateType {
    return !isEnabled ? .disabled : configuration.isPressed ? .selected : .enabled
  }
  
  func backgroundColor(_ buttonState: ButtonStateType) -> Color {
    switch buttonApperance {
    case .solid:
      switch buttonState {
      case .enabled: return ColorToken.container(.enableSecondary).color
      case .selected: return ColorToken.container(.pressed).color
      case .disabled: return ColorToken.container(.disableSecondary).color
      }
    case .kakao:
      return ColorToken.container(.kakao).color
    case .generalSignIn:
      return Color.white
    }
  }
  
  func foregroundColor(_ buttonState: ButtonStateType) -> Color {
    
    switch buttonApperance {
    case .solid:
      switch buttonState {
      case .enabled: return ColorToken.text(.enablePrimary).color
      case .selected: return ColorToken.text(.pressed).color
      case .disabled: return ColorToken.text(.disablePrimary).color
      }
      
    case .kakao:
      return ColorToken.text(.primary).color
      
    case .generalSignIn:
      return ColorToken.text(.primary).color
    }
  }
}

