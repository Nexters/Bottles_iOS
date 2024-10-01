//
//  SegmentControlButtonStyle.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 10/1/24.
//

import SwiftUI

struct SegmentControlButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled: Bool
  private let isSelected: Bool?
  
  public init(isSelected: Bool? = nil) {
    self.isSelected = isSelected
  }
  
  func makeBody(configuration: Configuration) -> some View {
    let buttonState = makeButtonState(configuration)
    
    return configuration.label
      .padding(.horizontal, .sm)
      .frame(height: 42)
      .foregroundStyle(foregroundColor(buttonState))
      .overlay(alignment: .bottom) {
        switch buttonState {
        case .enabled:
          EmptyView()
        case .selected:
          Divider()
            .frame(height: 2)
            .background(to: ColorToken.border(.selected))
        case .disabled:
          EmptyView()
        }
      }
  }
}

// MARK: - Private Methods
private extension SegmentControlButtonStyle {
  func makeButtonState(_ configuration: Configuration) -> ButtonStateType {
    return !isEnabled ? .disabled : configuration.isPressed || isSelected == true ? .selected : .enabled
  }
  
  func foregroundColor(_ buttonState: ButtonStateType) -> Color {
    switch buttonState {
    case .enabled:
      return ColorToken.text(.enableSecondary).color
    case .selected:
      return ColorToken.text(.selectPrimary).color
    case .disabled:
      return ColorToken.text(.disableSecondary).color
    }
  }
}
 
