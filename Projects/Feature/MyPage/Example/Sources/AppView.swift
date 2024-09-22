import SwiftUI

import FeatureMyPageInterface
import FeatureMyPage

import ComposableArchitecture

@main
struct AppView: App {
  var body: some Scene {
    WindowGroup {
      MyPageRootView(store: Store(
        initialState: MyPageRootFeature.State(),
        reducer: { MyPageRootFeature() }
      ))
    }
  }
}
