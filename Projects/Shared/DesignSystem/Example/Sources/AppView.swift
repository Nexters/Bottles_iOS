import SwiftUI

import SharedDesignSystem

@main
struct AppView: App {
  var body: some Scene {
    WindowGroup {
      RootView {
        DesignSystemExampleView()
          .onAppear {
            SharedDesignSystemFontFamily.registerAllCustomFonts()
          }
      }
    }
  }
}
