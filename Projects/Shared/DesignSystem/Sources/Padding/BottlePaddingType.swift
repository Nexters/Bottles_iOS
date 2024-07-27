//
//  BottlePaddingType.swift
//  DesignSystemExample
//
//  Created by 임현규 on 7/27/24.
//

import SwiftUI

public enum BottlePaddingType {
  case xl
  case md
  case sm
  case xs
  
  var length: CGFloat {
    switch self {
    case .xl: return 24
    case .md: return 16
    case .sm: return 12
    case .xs: return 8
    }
  }
}
