//
//  ClipItem.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/2/24.
//

import Foundation

public struct ClipItem: Hashable {
  var title: String
  var list: [String]
  
  public init(title: String, list: [String]) {
    self.title = title
    self.list = list
  }
}
