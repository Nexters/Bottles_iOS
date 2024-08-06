import SwiftUI

import FeatureSandBeachInterface
import FeatureSandBeach

import ComposableArchitecture

@main
struct AppView: App {
  private let rootStore = Store(
    initialState: SandBeachRootFeature.State(
      sandBeach: .init(userState: .noIntroduction)),
    reducer: { SandBeachRootFeature() })
  
  var body: some Scene {
    WindowGroup {
      SandBeachRootView(store: rootStore)
    }
  }
}
