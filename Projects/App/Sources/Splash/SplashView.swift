import SwiftUI

import CoreUtil

import ComposableArchitecture

public struct SplashView: View {
  private var store: StoreOf<SplashFeature>
  
  init(store: StoreOf<SplashFeature>) {
    self.store = store
  }
  
  public var body: some View {
    Text("Splash View")
      .onLoadTask {
        store.send(.viewLoaded)
      }
  }
}
