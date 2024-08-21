//
//  AppDelegate.swift
//  Bottle
//
//  Created by JongHoon on 7/23/24.
//

import SwiftUI

import CoreLoggerInterface
import Feature

import ComposableArchitecture
import FirebaseCore
import FirebaseMessaging

final class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {
  var store = Store(
    initialState: AppFeature.State(),
    reducer: { AppFeature() }
  )
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    UIApplication.shared.registerForRemoteNotifications()
    UNUserNotificationCenter.current().delegate = self
    Messaging.messaging().delegate = self
    
    let authOptions: UNAuthorizationOptions = [
        .alert,
        .badge,
        .sound
    ]
    UNUserNotificationCenter.current().requestAuthorization(
        options: authOptions,
        completionHandler: { _, error in
            if let error = error {
                Log.error(error)
            }
    })
    application.registerForRemoteNotifications()
    
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

extension AppDelegate: UNUserNotificationCenterDelegate {
  func messaging(
    _ messaging: Messaging,
    didReceiveRegistrationToken fcmToken: String?
  ) {
    Log.debug("fcm token: \(fcmToken ?? "NO TOKEN")")
    if let fcmToken {
      // TODO: user defaults 설정 방법 변경
      UserDefaults.standard.set(fcmToken, forKey: "fcmToken")
    }
  }
  
  func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    Messaging.messaging().apnsToken = deviceToken
  }
  
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification
  ) async -> UNNotificationPresentationOptions {
    return [.badge, .sound, .banner, .list]
  }
}
