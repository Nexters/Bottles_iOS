import SwiftUI

import ComposableArchitecture
import FeatureProfileSetupInterface

@main
struct AppView: App {
  let store = Store(
    initialState: IntroductionSetupFeature.State(),
    reducer: { IntroductionSetupFeature() })
  
  var body: some Scene {
    WindowGroup {
      IntroductionSetupView(store: store)
    }
  }
}
