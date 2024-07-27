//
//  RobotoStyleTextTestView.swift
//  SharedDesignSystem
//
//  Created by JongHoon on 7/27/24.
//

import SwiftUI

import SharedDesignSystem

struct RobotoStyleTextTestView: View {
  var body: some View {
    ScrollView {
      VStack(spacing: 8.0) {
        ForEach(
          Array(zip(
            0..<Font.BottleFontSystem.Roboto.allCases.count,
            Font.BottleFontSystem.Roboto.allCases)),
          id: \.0
        ) { _, style in
          RobotoStyleText(
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
  RobotoStyleTextTestView()
}
