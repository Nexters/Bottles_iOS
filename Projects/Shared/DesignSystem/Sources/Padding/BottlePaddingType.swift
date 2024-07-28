//
//  BottlePaddingType.swift
//  DesignSystemExample
//
//  Created by 임현규 on 7/27/24.
//

import SwiftUI

public enum BottlePaddingType {
  /// 24.0
  case xl
  /// 16.0
  case md
  /// 12.0
  case sm
  /// 8.0
  case xs
  
  public var length: CGFloat {
    switch self {
    case .xl: return 24
    case .md: return 16
    case .sm: return 12
    case .xs: return 8
    }
  }
}
