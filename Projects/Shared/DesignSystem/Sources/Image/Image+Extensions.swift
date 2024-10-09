//
//  Image+Extensions.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/3/24.
//

import SwiftUI

public extension Image {
  enum BottleImageSystem: Imageable {
    case icon(Icon)
    case illustraition(Illustraition)
    
    public var image: Image {
      switch self {
      case .icon(let icon):
        return icon.image
      case .illustraition(let illustraition):
        return illustraition.image
      }
    }
    
    public var description: String {
      switch self {
      case .icon:
        return "icon"
      case .illustraition:
        return "illustraition"
      }
    }
  }
}
