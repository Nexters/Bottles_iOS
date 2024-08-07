//
//  ImagePickerButton.swift
//  DesignSystemExample
//
//  Created by 임현규 on 8/3/24.
//

import SwiftUI

public struct ImagePickerButton: View {
  @Binding private var selectedImage: [UIImage]
  private var action: () -> Void
  
  public init(
    selectedImage: Binding<[UIImage]>,
    action: @escaping () -> Void
  ) {
    self._selectedImage = selectedImage
    self.action = action
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
          image.clipShape(RoundedRectangle(cornerRadius: BottleRadiusType.md.value))
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
        .overlay(alignment: .topTrailing) {
          deleteButton
        }
    } else {
      LocalImageView(.icom(.plus))
    }
  }
  
  var deleteButton: some View {
    RoundedRectangle(cornerRadius: BottleRadiusType.xs.value)
      .strokeBorder(ColorToken.border(.enabled).color, lineWidth: 1)
      .background(to: ColorToken.container(.enablePrimary))
      .clipShape(RoundedRectangle(cornerRadius: BottleRadiusType.xs.value))
      .frame(width: 36, height: 36)
      .overlay {
        LocalImageView(.icom(.clearDelete))
          .asThrottleButton {
            self.selectedImage.removeAll()
            action()
          }
      }
      .padding(.top, .md)
      .padding(.trailing, .md)
  }
}
