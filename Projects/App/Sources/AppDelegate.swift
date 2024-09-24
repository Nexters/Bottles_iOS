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
    setNotification()
    application.registerForRemoteNotifications()
    store.send(.appDelegate(.didFinishLunching))
    return true
  }
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
  func messaging(
    _ messaging: Messaging,
    didReceiveRegistrationToken fcmToken: String?
  ) {
    Log.debug("fcm token: \(fcmToken ?? "NO TOKEN")")
    if let fcmToken {
      // TODO: user defaults 설정 방법 변경
      store.send(.appDelegate(.didReceivedFcmToken(fcmToken: fcmToken)))
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

// MARK: - objc funcs
private extension AppDelegate {
  @objc func checkNotificationSetting() {
    UNUserNotificationCenter.current()
      .getNotificationSettings { [weak self] permission in
        guard let self = self else { return }
        DispatchQueue.main.async {
          switch permission.authorizationStatus {
          case .notDetermined:
            self.store.send(.appDelegate(.notificationSettingDidChanged(isAllow: true)))
          case .denied:
            self.store.send(.appDelegate(.notificationSettingDidChanged(isAllow: false)))
          case .authorized:
            self.store.send(.appDelegate(.notificationSettingDidChanged(isAllow: true)))
          case .provisional:
            self.store.send(.appDelegate(.notificationSettingDidChanged(isAllow: false)))
          case .ephemeral:
            self.store.send(.appDelegate(.notificationSettingDidChanged(isAllow: true)))
          @unknown default:
            Log.error("Unknow Notification Status")
          }
        }
      }
  }
}

// MARK: - Private Methods
private extension AppDelegate {
  func setNotification() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(checkNotificationSetting),
      name: UIApplication.willEnterForegroundNotification,
      object: nil
    )
  }
}
