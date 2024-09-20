//
//  BottleToggle.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 9/2/24.
//

import SwiftUI

public struct BottleToggle: View {
  @Binding private var isOn: Bool
  
  public init(isOn: Binding<Bool>) {
    self._isOn = isOn
  }
  
  public var body: some View {
    Toggle("", isOn: $isOn)
      .toggleStyle(BottleToggleStyle())
  }
}

// MARK: - ToggleStyle
private struct BottleToggleStyle: ToggleStyle {
  private let width: CGFloat = 44
  private let height: CGFloat = 26
  
  func makeBody(configuration: Configuration) -> some View {
    ZStack(alignment: configuration.isOn ? .trailing : .leading) {
      RoundedRectangle(cornerRadius: 100)
        .frame(width: width, height: height)
        .foregroundStyle(to: configuration.isOn ?  ColorToken.container(.pressed) : ColorToken.icon(.disabled))
      
      RoundedRectangle(cornerRadius: width / 2)
        .frame(width: (width / 2), height: (width / 2))
        .padding(2)
        .foregroundStyle(to: ColorToken.container(.primary))
        .onTapGesture {
          withAnimation {
            configuration.$isOn.wrappedValue.toggle()
          }
        }
    }
  }
}
