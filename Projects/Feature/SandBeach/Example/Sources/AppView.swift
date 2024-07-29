import SwiftUI

import FeatureSandBeachInterface
import FeatureSandBeach

import ComposableArchitecture

@main
struct AppView: App {
  private let store = Store(
    initialState: SandBeachFeature.State(),
    reducer: { SandBeachFeature() }
  )
  var body: some Scene {
    WindowGroup {
      SandBeachView(store: store)
        .border(.red)
    }
  }
}

