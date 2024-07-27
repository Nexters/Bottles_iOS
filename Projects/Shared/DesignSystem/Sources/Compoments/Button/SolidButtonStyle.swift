//
//  SolidButtonStyle.swift
//  DesignSystemExample
//
//  Created by 임현규 on 7/27/24.
//

import SwiftUI

struct SolidButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled: Bool
  
  let sizeType: SolidButton.SizeType
  
  enum ButtonStateType {
    case enabled
    case selected
    case disabled
    
    var backgroundColor: Color {
      switch self {
      case .enabled: return ColorToken.container(.enableSecondary).color
      case .selected: return ColorToken.container(.pressed).color
      case .disabled: return ColorToken.container(.disableSecondary).color
      }
    }
    
    var foregroundColor: Color {
      switch self {
      case .enabled: return ColorToken.text(.enablePrimary).color
      case .selected: return ColorToken.text(.pressed).color
      case .disabled: return ColorToken.text(.disablePrimary).color
      }
    }
  }
  
  func makeBody(configuration: Configuration) -> some View {
    var buttonState: ButtonStateType {
      if configuration.isPressed {
        return .selected
      }
      
      if isEnabled {
        return .enabled
      }
      
      return .disabled
    }

    return configuration.label
      .padding(.horizontal, .sm)
      .frame(height: height)
      .frame(maxWidth: width)
      .foregroundStyle(buttonState.foregroundColor)
      .background {
        RoundedRectangle(cornerRadius: cornerRadius.value)
          .fill(buttonState.backgroundColor)
      }
  }
}

// MARK: - Private Extension

private extension SolidButtonStyle {
  var height: CGFloat {
    switch sizeType {
    case .extraSmall: return 36
    case .small:      return 56
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
}
