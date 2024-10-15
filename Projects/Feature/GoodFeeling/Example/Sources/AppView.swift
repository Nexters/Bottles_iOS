import SwiftUI

import FeatureGoodFeeling
import FeatureGoodFeelingInterface

import DomainAuth
import DomainAuthInterface

import ComposableArchitecture

@main
struct AppView: App {
  var body: some Scene {
    WindowGroup {
      GoodFeelingRootView(store: Store(
        initialState: GoodFeelingRootFeature.State(),
        reducer: { GoodFeelingRootFeature() }
      ))
    }
  }
}
