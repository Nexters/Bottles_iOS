import SwiftUI

import FeatureSandBeachInterface
import FeatureSandBeach

import ComposableArchitecture

@main
struct AppView: App {
  private let store = Store(
    initialState: SandBeachFeature.State(userState: .noIntroduction),
    reducer: { SandBeachFeature() }
  )
  var body: some Scene {
    WindowGroup {
      SandBeachView(store: store)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      SandBeachView(store: Store(
        initialState: SandBeachFeature.State(userState: .noIntroduction),
        reducer: { SandBeachFeature() }
      ))
    }
}
