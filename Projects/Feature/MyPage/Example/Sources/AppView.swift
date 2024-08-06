import SwiftUI

import FeatureMyPageInterface
import FeatureMyPage

import ComposableArchitecture

@main
struct AppView: App {
  var body: some Scene {
    WindowGroup {
      MyPageView(store: Store(
        initialState: MyPageFeature.State(),
        reducer: { MyPageFeature() }
      ))
    }
  }
}
