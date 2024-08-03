//
//  ImagePickerButton.swift
//  DesignSystemExample
//
//  Created by 임현규 on 8/3/24.
//

import SwiftUI

public struct ImagePickerButton: View {
  public init() {}
  
  public var body: some View {
    GeometryReader { geometry in
      let width = geometry.size.width
      let height = width
      
      RoundedRectangle(cornerRadius: BottleRadiusType.md.value)
        .strokeBorder(
          ColorToken.border(.enabled).color,
          lineWidth: 1
        )
        .frame(width: width)
        .frame(height: height)
        .overlay(alignment: .center) {
          LocalImageView(.icom(.plus))
        }
    }
  }
}

#Preview {
  ImagePickerButton()
}
