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
      Color(.black)
        .opacity(0.5)
      
      LottieView(animation: try? .from(data: SharedDesignSystemAsset.Lotties.progressIndicator.data.data))
        .looping()
        .frame(width: 150.0, height: 84.0)
    }
    .ignoresSafeArea()
  }
}

#Preview {
  LoadingIndicator()
}
