import SwiftUI

import Feature
import CoreLoggerInterface

import ComposableArchitecture
import KakaoSDKAuth

@main
struct AppRoot: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
  @Environment(\.scenePhase) private var scenePhase
  
  var body: some Scene {
    WindowGroup {
      AppView(store: appDelegate.store)
        .onOpenURL(perform: { url in
          if (AuthApi.isKakaoTalkLoginUrl(url)) {
            _ = AuthController.handleOpenUrl(url: url)
          }
        }
      )
    }
  }
}
