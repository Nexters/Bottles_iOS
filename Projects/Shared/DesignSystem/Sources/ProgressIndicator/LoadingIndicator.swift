//
//  LoadingIndicator.swift
//  DesignSystemExample
//
//  Created by JongHoon on 8/7/24.
//

import SwiftUI

import Lottie

public struct LoadingIndicator: View {
  
  public init() {}
  
  public var body: some View {
    ZStack {
      ColorToken.background(.primary).color
      
      LottieView(animation: try? .from(data: SharedDesignSystemAsset.Lotties.bottleLoadingEllipse.data.data))
        .looping()
        .frame(width: 100.0, height: 100.0)
    }
    .ignoresSafeArea()
  }
}

#Preview {
  LoadingIndicator()
}
