import SwiftUI

import CoreUtil
import Feature

import ComposableArchitecture

public struct SplashView: View {
  private var store: StoreOf<SplashFeature>
  
  init(store: StoreOf<SplashFeature>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStack {
      VStack {
        Text("Splash View")
          .onLoadTask {
            store.send(.viewLoaded, animation: .default)
          }
      }
    }
  }
}
