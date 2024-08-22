import SwiftUI

import FeatureLoginInterface
import FeatureLogin

import ComposableArchitecture
import KakaoSDKAuth
import KakaoSDKCommon

@main
struct AppView: App {
  let store = Store(
    initialState: LoginFeature.State(),
    reducer: { LoginFeature() }
  )
    var body: some Scene {
        WindowGroup {
           LoginView(store: store)
            .onAppear(perform: {
              guard let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_APP_KEY"] as? String else {
                fatalError("XCConfig Setting Error")
              }
              
              KakaoSDK.initSDK(appKey: kakaoAppKey)

            })
            .onOpenURL(perform: { url in
              if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
              }
            }
          )
        }
    }
}

