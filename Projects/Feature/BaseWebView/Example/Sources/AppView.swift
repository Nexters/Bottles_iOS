import SwiftUI

import ComposableArchitecture

@main
struct AppView: App {
  private var store = Store(
    initialState: BaseWebViewSettingFeature.State(),
    reducer: { BaseWebViewSettingFeature() }
  )
  var body: some Scene {
    WindowGroup {
      BaseWebViewSettingView(store: store)
    }
  }
}

