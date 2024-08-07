//
//  ProgressIndicator.swift
//  DesignSystemExample
//
//  Created by JongHoon on 8/7/24.
//

import SwiftUI

import Lottie

public struct ProgressIndicator: View {
  
  public init() {}
  
  public var body: some View {
    LottieView(animation: try? .from(data: SharedDesignSystemAsset.Lotties.progressIndicator.data.data))
      .looping()
      .frame(width: 150.0, height: 84.0)
  }
}

#Preview {
  ProgressIndicator()
}
