//
//  RemoteImageView.swift
//  SharedDesignSystem
//
//  Created by JongHoon on 7/28/24.
//

import SwiftUI

import Kingfisher

public struct RemoteImageView: View {
  private let imageURL: String
  private let downsamplingSize: CGSize
  
  public init(
    imageURL: String,
    downsamplingWidth: Double,
    downsamplingHeight: Double
  ) {
    self.imageURL = imageURL
    self.downsamplingSize = CGSize(
      width: downsamplingWidth,
      height: downsamplingHeight
    )
  }
  
  public var body: some View {
    KFImage(URL(string: imageURL))
      .cancelOnDisappear(true)
      .placeholder {
        ColorToken.icon(.secondary).color
      }
      .downsampling(size: downsamplingSize)
      .scaleFactor(UIScreen.main.scale)
      .cacheOriginalImage()
      .retry(maxCount: 3, interval: .seconds(2))
      .resizable()
      .scaledToFill()
  }
}
