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
        // TODO: 플레이스 홀더 정해지면 수정필요
        Color.BottleColorSystem.neutral(.neutral400).color
      }
      .downsampling(size: downsamplingSize)
      .scaleFactor(UIScreen.main.scale)
      .cacheOriginalImage()
      .retry(maxCount: 3, interval: .seconds(2))
      .resizable()
  }
}
