//
//  Image+Extensions.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/3/24.
//

import SwiftUI

public extension Image {
  enum BottleImageSystem: Imageable {
    case icom(Icon)
    
    public var image: Image {
      switch self {
      case .icom(let icon):
        return icon.image
      }
    }
  }
}
