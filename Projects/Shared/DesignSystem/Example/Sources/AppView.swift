import SwiftUI

import SharedDesignSystem

@main
struct AppView: App {
  var body: some Scene {
    WindowGroup {
      DesignSystemExampleView()
        .onAppear {
          SharedDesignSystemFontFamily.registerAllCustomFonts()
        }
    }
  }
}
