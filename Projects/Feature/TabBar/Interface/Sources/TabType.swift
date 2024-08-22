//
//  TabType.swift
//  Feature
//
//  Created by JongHoon on 7/27/24.
//

import SwiftUI
import SharedDesignSystem

public enum TabType: Hashable, CaseIterable {
  case sandBeach
  case bottleStorage
  case myPage
  
  public var title: String {
    switch self {
    case .sandBeach:
      return "모래사장"
      
    case .bottleStorage:
      return "보틀 보관함"
      
    case .myPage:
      return "마이페이지"
    }
  }
  
  var image: Image.BottleImageSystem {
    switch self {
    case .sandBeach:
      return .icom(.sandBeach)
      
    case .bottleStorage:
      return .icom(.bottleStorage)
      
    case .myPage:
      return .icom(.myPage)
    }
  }
}
