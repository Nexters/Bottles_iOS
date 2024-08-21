//
//  SplashView.swift
//  Feature
//
//  Created by 임현규 on 8/12/24.
//

import SwiftUI
import SharedDesignSystem

public struct SplashView: View {
  public init() {}
  public var body: some View {
    ZStack {
      ColorToken.container(.pressed).color
        .ignoresSafeArea()
      
      Image.BottleImageSystem.illustraition(.splash).image
    }
    .ignoresSafeArea()
  }
}
