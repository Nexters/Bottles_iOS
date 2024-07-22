import SwiftUI

import ComposableArchitecture

@main
struct RootApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(store: Store(
              initialState: SplashFeature.State(),
              reducer: { SplashFeature() }
            ))
        }
    }
}
