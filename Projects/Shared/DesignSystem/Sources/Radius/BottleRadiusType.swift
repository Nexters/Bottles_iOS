//
//  BottleRadiusType.swift
//  DesignSystemExample
//
//  Created by 임현규 on 7/27/24.
//

import Foundation

public enum BottleRadiusType {

  /// 24.0
  case xl
  /// 2.0
  case lg
  /// 16.0
  case md
  /// 12.0
  case sm
  /// 8.0
  case xs
  
  public var value: CGFloat {
    switch self {
    case .xl: return 24
    case .lg: return 20
    case .md: return 16
    case .sm: return 12
    case .xs: return 8
    }
  }
}
