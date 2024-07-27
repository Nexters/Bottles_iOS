import SwiftUI

import Feature

import ComposableArchitecture

@main
struct AppRoot: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
  @Environment(\.scenePhase) private var scenePhase
  
  var body: some Scene {
    WindowGroup {
      AppView(store: appDelegate.store)
    }
  }
}
