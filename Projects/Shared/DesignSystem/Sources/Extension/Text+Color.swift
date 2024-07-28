//
//  Text+Color.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/28/24.
//

import SwiftUI

public extension Text {
  // MARK: - colorToken
  func foregroundStyle(to colorToken: ColorToken) -> Text {
    self.foregroundStyle(colorToken.color)
  }
}
