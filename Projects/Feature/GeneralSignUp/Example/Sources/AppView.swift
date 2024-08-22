import SwiftUI

import FeatureGeneralSignUpInterface
import FeatureGeneralSignUp

import ComposableArchitecture

@main
struct AppView: App {
  var body: some Scene {
    WindowGroup {
      GeneralSignUpView(store: Store(
        initialState: GeneralSignUpFeature.State(),
        reducer: { GeneralSignUpFeature() }
      ))
    }
  }
}

