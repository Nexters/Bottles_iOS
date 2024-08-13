//
//  TabType.swift
//  Feature
//
//  Created by JongHoon on 7/27/24.
//

public enum TabType: Hashable {
  case sandBeach
  case bottleStorage
  case myPage
  
  var title: String {
    switch self {
    case .sandBeach:
      return "모래사장"
      
    case .bottleStorage:
      return "보틀 보관함"
      
    case .myPage:
      return "마이페이지"
    }
  }
}
