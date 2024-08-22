//
//  OutlinedButtonStyle.swift
//  SharedDesignSystem
//
//  Created by JongHoon on 7/28/24.
//

import SwiftUI

public struct OutlinedButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled: Bool
  private let configurationInfo: OutlinedStyleButton.ConfigurationInfo
  private let isSelected: Bool?
  
  public init(
    configurationInfo: OutlinedStyleButton.ConfigurationInfo,
    isSelected: Bool? = nil
  ) {
    self.configurationInfo = configurationInfo
    self.isSelected = isSelected
  }
  
  public func makeBody(configuration: Configuration) -> some View {
    let buttonState = buttonState(configuration: configuration)
    
    return configuration.label
      .padding(.horizontal, horizontalPadding)
      .padding(.vertical, verticalPadding)
      .frame(maxWidth: width)
      .frame(height: height)
      .foregroundStyle(foregroundColor(buttonState: buttonState))
      .background(backgroundColor(buttonState: buttonState))
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
      .overlay(
        RoundedRectangle(cornerRadius: cornerRadius)
          .strokeBorder(
            borderColor(buttonState: buttonState),
            lineWidth: 1.0
          )
      )
  }
  
  private func baseButtonLabel(configuration: Configuration) -> some View {
    let buttonState = buttonState(configuration: configuration)
    
    return configuration.label
      .padding(.horizontal, horizontalPadding)
      .padding(.vertical, verticalPadding)
      .overlay(
        RoundedRectangle(cornerRadius: BottleRadiusType.xs.value)
          .strokeBorder(
            borderColor(buttonState: buttonState),
            lineWidth: 1.0
          )
      )
      .frame(width: width, height: height)
      .foregroundStyle(foregroundColor(buttonState: buttonState))
      .background(backgroundColor(buttonState: buttonState))
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
  }
}

// MARK: - Private Method

private extension OutlinedButtonStyle {
  func buttonState(configuration: Configuration) -> ButtonStateType {
    if !isEnabled { return .disabled }
    
    if configuration.isPressed || isSelected == true { return .selected }
    
    return .enabled
  }
  
  func borderColor(buttonState: ButtonStateType) -> Color {
    switch buttonState {
    case .enabled:
      return ColorToken.border(.enabled).color
      
    case .selected:
      return ColorToken.border(.selected).color
      
    case .disabled:
      return ColorToken.border(.enabled).color
    }
  }
  
  func backgroundColor(buttonState: ButtonStateType) -> Color {
    switch buttonState {
    case .enabled:
      return ColorToken.container(.enablePrimary).color
      
    case .selected:
      return ColorToken.container(.selected).color
      
    case .disabled:
      return ColorToken.container(.disablePrimary).color
    }
  }
  
  func foregroundColor(buttonState: ButtonStateType) -> Color {
    switch buttonState {
    case .enabled:
      return ColorToken.text(.secondary).color
      
    case .selected:
      return ColorToken.text(.selectPrimary).color
      
    case .disabled:
      return ColorToken.text(.disableSecondary).color
    }
  }
  
  var horizontalPadding: CGFloat? {
    switch configurationInfo {
    case .small:
      return 12.0
      
    case .medium:
      return 21.0
      
    case .large:
      return 0.0
    }
  }
  
  var verticalPadding: CGFloat? {
    switch configurationInfo {
    case .small:
      return nil
      
    case let .medium(contentType):
      switch contentType {
      case .text:
        return nil
        
      case .image:
        return 23.5
      }
      
    case .large:
      return nil
    }
  }
  
  var height: CGFloat {
    switch configurationInfo {
    case .small:
      return 36.0
   
    // TODO: 논의 후 수정 필요
    case let .medium(contentType):
      switch contentType {
      case .text:
        return 56.0
        
      case .image:
        return 180.0
      }
      
    case .large:
      return 56.0
    }
  }
  
  var width: CGFloat? {
    switch configurationInfo {
    case .small:
      return nil
      
    case .medium:
      return .infinity
      
    case .large:
      return .infinity
    }
  }
  
  var cornerRadius: CGFloat {
    switch configurationInfo {
    case let .small(contentType):
      switch contentType {
      case .text:
        return BottleRadiusType.xs.value
      case .image:
        return BottleRadiusType.sm.value
      }
      
    case .medium:
      return BottleRadiusType.sm.value
      
    case .large:
      return BottleRadiusType.sm.value
    }
  }
}
