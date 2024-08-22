//
//  BottleImageView.swift
//  DesignSystemExample
//
//  Created by JongHoon on 7/27/24.
//

import SwiftUI

public struct BottleImageView: View {
  private let type: ImageViewType
  
  public init(type: ImageViewType) {
    self.type = type
  }
  
  public var body: some View {
    switch type {
    case let .local(bottleImageSystem):
      LocalImageView(bottleImageSystem)
      
    case let .remote(url, downsamplingWidth, downsamplingHeight):
      RemoteImageView(
        imageURL: url,
        downsamplingWidth: downsamplingWidth,
        downsamplingHeight: downsamplingHeight
      )
    }
  }
}
