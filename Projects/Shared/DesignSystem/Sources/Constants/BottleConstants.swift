//
//  BottleConstants.swift
//  DesignSystemExample
//
//  Created by JongHoon on 9/1/24.
//

import UIKit

public enum BottleConstants {
  case deviceHeight
  case deviceWidth
  case bottomTabBarHeight
  
  public var value: CGFloat {
    switch self {
    case .deviceHeight:
      return UIScreen.main.bounds.height
    case .deviceWidth:
      return UIScreen.main.bounds.width
    case .bottomTabBarHeight:
      return 106.0
    }
  }
}
