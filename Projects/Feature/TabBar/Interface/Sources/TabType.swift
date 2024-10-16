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
  case goodFeeling
  case bottleStorage
  case myPage
  
  public var title: String {
    switch self {
    case .sandBeach:
      return "모래사장"
      
    case .goodFeeling:
      return "호감"
      
    case .bottleStorage:
      return "문답"
      
    case .myPage:
      return "마이페이지"
    }
  }
  
  var image: Image.BottleImageSystem {
    switch self {
    case .sandBeach:
      return .icon(.sandBeach)
      
    case .goodFeeling:
      return .icon(.goodFeeling)
      
    case .bottleStorage:
      return .icon(.talk)
      
    case .myPage:
      return .icon(.myPage)
    }
  }
}
