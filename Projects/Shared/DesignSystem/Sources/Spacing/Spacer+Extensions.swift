//
//  Spacer+Extensions.swift
//  DesignSystemExample
//
//  Created by 임현규 on 7/27/24.
//

import SwiftUI

public extension Spacer {
  enum BottleSpacingType: Spacable {
    case xxl
    case xl
    case lg
    case md
    case sm
    case xs
    case xxs
    
    var minLength: CGFloat {
      switch self {
      case .xxl: return 32
      case .xl: return 24
      case .lg: return 20
      case .md: return 16
      case .sm: return 12
      case .xs: return 8
      case .xxs: return 4
      }
    }
  }
}

public extension Spacer {
  init(_ bottleSpacingType: BottleSpacingType) {
    self.init(minLength: bottleSpacingType.minLength)
  }
}
