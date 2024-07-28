//
//  ImageViewType.swift
//  DesignSystemExample
//
//  Created by JongHoon on 7/27/24.
//

public enum ImageViewType {
  case local(imageNmae: String)
  case remote(url: String, downsamplingWidth: Double, downsamplingHeight: Double)
}
