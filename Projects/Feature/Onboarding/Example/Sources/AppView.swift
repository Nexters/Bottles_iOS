import SwiftUI

import FeatureOnboarding
import FeatureOnboardingInterface

import ComposableArchitecture

@main
struct AppView: App {
  var body: some Scene {
    WindowGroup {
      OnboardingView(store: Store(
        initialState: OnboardingFeature.State(),
        reducer: { OnboardingFeature() }
      ))
    }
  }
}
