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
  
  let photoShareGuideStore = Store(
    initialState: PhotoShareGuideFeature.State(),
    reducer: { PhotoShareGuideFeature() })
  
  let startGuideStore = Store(
    initialState: StartGuideFeature.State(),
    reducer: { StartGuideFeature() })
  
  var body: some Scene {
    
    WindowGroup {
//              MainGuideView(store: mainGuideStore)
//      PingPongGuideView(store: pingpongGuideStore)
//      PhotoShareGuideView(store: photoShareGuideStore)
      StartGuideView(store: startGuideStore)
    }
  }
}

