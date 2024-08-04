//
//  ToastTestView.swift
//  DesignSystemExample
//
//  Created by JongHoon on 8/4/24.
//

import SwiftUI
import SharedDesignSystem

struct ToastTestView: View {
  @State private var presentSheet = false
  
  var body: some View {
    VStack(spacing: 8.0) {
      Text("Present Text")
        .asButton {
          ToastManager.shared.present(message: "test", durationSecond: 3.0)
        }
      
      Text("present sheet")
        .asButton {
          presentSheet = true
        }
    }
    .sheet(
      isPresented: $presentSheet,
      content: {
        Text("Present Text")
          .asButton {
            ToastManager.shared.present(message: "test", durationSecond: 3.0)
          }
      }
    )
  }
}
