//
//  DesignSystemExampleView.swift
//  DesignSystemExample
//
//  Created by JongHoon on 7/27/24.
//

import SwiftUI

import SharedDesignSystem

struct DesignSystemExampleView: View {
  var body: some View {
    NavigationStack {
      List {
        Section(
          content: {
            NavigationLink(
              destination: WantedSansStyleTextTestView(),
              label: { Text("Wanted Sans Text Test View") }
            )
            NavigationLink(
              destination: RobotoStyleTextTestView(),
              label: { Text("Roboto Text Test View") }
            )
            NavigationLink(
              destination: LaundaryGothicsStyleTextTestView(),
              label: { Text("Laundary Gothic Text Test View") }
            )
          },
          header: {
            Text("Custom Text View")
              .font(.headline)
          }
        )
      }
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Design System Example View")
    }
  }
}

#Preview {
  DesignSystemExampleView()
}
