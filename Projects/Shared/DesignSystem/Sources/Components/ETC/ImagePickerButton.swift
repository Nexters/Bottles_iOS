//
//  ImagePickerButton.swift
//  DesignSystemExample
//
//  Created by 임현규 on 8/3/24.
//

import SwiftUI

public struct ImagePickerButton: View {
  @Binding private var selectedImage: [UIImage]
  
  public init(selectedImage: Binding<[UIImage]>) {
    self._selectedImage = selectedImage
  }
  
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
          image
            .padding(.xl)
        }
    }
  }
}

private extension ImagePickerButton {
  @ViewBuilder
  var image: some View {
    if let selectedImage = selectedImage.first {
      Image(uiImage: selectedImage)
        .resizable()
        .scaledToFit()
        .clipped()
    } else {
      LocalImageView(.icom(.plus))
    }
  }
}
