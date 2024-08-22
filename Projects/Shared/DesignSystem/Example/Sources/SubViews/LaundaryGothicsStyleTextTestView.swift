//
//  LaundaryGothicsStyleTextTestView.swift
//  SharedDesignSystem
//
//  Created by JongHoon on 7/27/24.
//

import SwiftUI

import SharedDesignSystem

struct LaundaryGothicsStyleTextTestView: View {
  var body: some View {
    ScrollView {
      VStack(spacing: 8.0) {
        ForEach(
          Array(zip(
            0..<Font.BottleFontSystem.LaundryGothic.allCases.count,
            Font.BottleFontSystem.LaundryGothic.allCases)),
          id: \.0
        ) { _, style in
          LaundryGothicStyleText(
            "Test",
            style: style,
            color: .primary
          )
          .border(.red)
        }
      }
    }
  }
}

#Preview {
  LaundaryGothicsStyleTextTestView()
}

