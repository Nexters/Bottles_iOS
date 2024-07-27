//
//  HStack+Spacing.swift
//  DesignSystemExample
//
//  Created by 임현규 on 7/27/24.
//

import SwiftUI

public extension HStack {
  init(alignment: VerticalAlignment = .center, spacing: Spacer.BottleSpacingType? = nil, @ViewBuilder content: () -> Content) {
    self.init(alignment: alignment, spacing: spacing?.minLength, content: content)
  }
}
