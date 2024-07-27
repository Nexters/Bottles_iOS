//
//  BottleRadiusType.swift
//  DesignSystemExample
//
//  Created by 임현규 on 7/27/24.
//

import Foundation

public enum BottleRadiusType {
  case xl
  case md
  case sm
  case xs
  
  var value: CGFloat {
    switch self {
    case .xl: return 24
    case .md: return 16
    case .sm: return 12
    case .xs: return 8
    }
  }
}
