//
//  ImageViewType.swift
//  DesignSystemExample
//
//  Created by JongHoon on 7/27/24.
//

import SwiftUI

public enum ImageViewType {
  case local(bottleImageSystem: Image.BottleImageSystem)
  case remote(url: String, downsamplingWidth: Double, downsamplingHeight: Double)
}
