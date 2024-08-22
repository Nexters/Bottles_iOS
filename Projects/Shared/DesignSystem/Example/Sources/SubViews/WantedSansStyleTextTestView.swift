//
//  WantedSansStyleTextTestView.swift
//  SharedDesignSystem
//
//  Created by JongHoon on 7/27/24.
//

import SwiftUI

import SharedDesignSystem

struct WantedSansStyleTextTestView: View {
  var body: some View {
    ScrollView {
      VStack(spacing: 8.0) {
        ForEach(
          Array(zip(
            0..<Font.BottleFontSystem.WantedSans.allCases.count,
            Font.BottleFontSystem.WantedSans.allCases)),
          id: \.0
        ) { _, style in
          WantedSansStyleText(
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
  WantedSansStyleTextTestView()
}
