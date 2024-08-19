//
//  BlurImageView.swift
//  SharedDesignSystem
//
//  Created by JongHoon on 8/17/24.
//

import SwiftUI

import Kingfisher

public struct BlurImageView: View {
  private let imageURL: String
  private let downsamplingWidth: Double
  private let downsamplingHeight: Double
  
  public init(
    imageURL: String,
    downsamplingWidth: Double,
    downsamplingHeight: Double
  ) {
    self.imageURL = imageURL
    self.downsamplingWidth = downsamplingWidth
    self.downsamplingHeight = downsamplingHeight
  }
  
  public var body: some View {
    KFImage(URL(string: imageURL))
      .cancelOnDisappear(true)
      .placeholder {
        ColorToken.icon(.secondary).color
      }
      .downsampling(size: .init(
        width: downsamplingWidth,
        height: downsamplingHeight
      ))
      .blur(radius: 3.0)
      .scaleFactor(UIScreen.main.scale)
      .cacheOriginalImage()
      .retry(maxCount: 3, interval: .seconds(2))
      .resizable()
      .scaledToFill()
  }
}

struct BlurView: UIViewRepresentable {
  var style: UIBlurEffect.Style
  
  func makeUIView(context: Context) -> UIVisualEffectView {
    return UIVisualEffectView(effect: UIBlurEffect(style: style))
  }
  
  func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
    uiView.effect = UIBlurEffect(style: style)
  }
}
