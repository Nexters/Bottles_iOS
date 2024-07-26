//
//  Font+Extensions.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/26/24.
//

import SwiftUI


public extension Font {
  enum BottleFontSystem: Fontable {
    case wantedSans(WantedSans)
    case roboto(Roboto)
    case laundryGothic(LaundryGothic)
    
    public var font: Font {
      switch self {
      case .wantedSans(let wantedSans):
        return wantedSans.font
      case .roboto(let roboto):
        return roboto.font
      case .laundryGothic(let laundryGothic):
        return laundryGothic.font
      }
    }
  }
}
