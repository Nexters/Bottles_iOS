//
//  ColorToken.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/27/24.
//

import SwiftUI

public enum ColorToken: Colorable {
  case brand(Brand)
  case background(Background)
  case container(Container)
  case onContainer(OnContainer)
  case text(TextToken)
  case border(Border)
  case icon(IconToken)
  
  public var color: Color {
    switch self {
    case .brand(let brand):
      return brand.color
    case .background(let background):
      return background.color
    case .container(let container):
      return container.color
    case .onContainer(let onContainer):
      return onContainer.color
    case .text(let textToken):
      return textToken.color
    case .border(let border):
      return border.color
    case .icon(let iconToken):
      return iconToken.color
    }
  }
}
