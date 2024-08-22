//
//  Spacer+Extensions.swift
//  DesignSystemExample
//
//  Created by 임현규 on 7/27/24.
//

import SwiftUI

public extension Spacer {
  enum BottleSpacingType: Spacable {
    /// 32.0
    case xxl
    /// 24.0
    case xl
    /// 20.0
    case lg
    /// 16.0
    case md
    /// 12.0
    case sm
    /// 8.0
    case xs
    /// 4.0
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
