//
//  PageIndicatorTestView.swift
//  DesignSystemExample
//
//  Created by 임현규 on 8/3/24.
//

import SwiftUI

import SharedDesignSystem

public struct PageIndicatorTestView: View {
  public init() {}
  
  public var body: some View {
    PageIndicatorView(nowNumber: 1, totalCount: 2)
  }
}

#Preview {
  PageIndicatorTestView()
}
