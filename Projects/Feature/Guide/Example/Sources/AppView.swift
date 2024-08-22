import SwiftUI

import FeatureGuideInterface

import ComposableArchitecture

@main
struct AppView: App {
  let mainGuideStore = Store(
    initialState: MainGuideFeature.State(),
    reducer: { MainGuideFeature() })
  
  let pingpongGuideStore = Store(
    initialState: PingPongGuideFeature.State(),
    reducer: { PingPongGuideFeature() })

  var body: some Scene {
    WindowGroup {
      MainGuideView(store: mainGuideStore)
//      PingPongGuideView(store: pingpongGuideStore)
      
    }
  }
}

