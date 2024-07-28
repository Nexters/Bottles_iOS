//
//  LocalImageView.swift
//  SharedDesignSystem
//
//  Created by JongHoon on 7/28/24.
//

import SwiftUI

public struct LocalImageView:View {
  // TODO: 추후 이미지 관련 네임스페이스 처리 후 개선 필요
  private let imageName: String
  
  public init(
    imageName: String
  ) {
    self.imageName = imageName
  }
  
  public var body: some View {
    Image(imageName)
  }
}
