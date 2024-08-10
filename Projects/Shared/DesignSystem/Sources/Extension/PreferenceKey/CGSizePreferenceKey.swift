//
//  File.swift
//  DesignSystemExample
//
//  Created by JongHoon on 8/10/24.
//

import SwiftUI

public struct CGSizePreferenceKey: PreferenceKey {
  public static var defaultValue: CGSize = .zero
  public static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
