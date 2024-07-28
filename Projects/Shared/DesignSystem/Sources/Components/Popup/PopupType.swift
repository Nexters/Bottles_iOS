//
//  PopupType.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/29/24.
//

import Foundation

public enum PopupType {
  case text(content: String)
  case button(content: String, buttonTitle: String)
  
  var content: String {
    switch self {
    case .text(let content):      return content
    case .button(let content, _): return content
    }
  }
}
