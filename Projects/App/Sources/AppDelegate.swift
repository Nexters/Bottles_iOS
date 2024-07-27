//
//  AppDelegate.swift
//  Bottle
//
//  Created by JongHoon on 7/23/24.
//

import SwiftUI

import Feature

import ComposableArchitecture

final class AppDelegate: UIResponder, UIApplicationDelegate {
  let store = Store(
    initialState: AppFeature.State(),
    reducer: { AppFeature() }
  )
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    store.send(.appDelegate(.didFinishLunching))
    return true
  }
}
