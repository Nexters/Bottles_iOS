//
//  DesignSystemExampleView.swift
//  DesignSystemExample
//
//  Created by JongHoon on 7/27/24.
//

import SwiftUI

struct DesignSystemExampleView: View {
  var body: some View {
    NavigationStack {
      List {
        Section(
          content: {
            NavigationLink(
              destination: TestView(),
              label: { Text("Test View") }
            )
            NavigationLink(
              destination: Text("Test Button"),
              label: { Text("Test Button") }
            )
          },
          header: {
            Text("Components")
              .font(.title)
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
