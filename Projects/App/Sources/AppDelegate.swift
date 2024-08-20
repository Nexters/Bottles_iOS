//
//  AppDelegate.swift
//  Bottle
//
//  Created by JongHoon on 7/23/24.
//

import SwiftUI

import Feature

import ComposableArchitecture
import FirebaseCore

final class AppDelegate: UIResponder, UIApplicationDelegate {
  var store = Store(
    initialState: AppFeature.State(),
    reducer: { AppFeature() }
  )
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    store.send(.appDelegate(.didFinishLunching))
    return true
  }
  
  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    let configuration = UISceneConfiguration(
      name: nil,
      sessionRole: connectingSceneSession.role
    )
    
    if connectingSceneSession.role == .windowApplication {
      configuration.delegateClass = SceneDelegate.self
    }
    
    return configuration
  }
}
