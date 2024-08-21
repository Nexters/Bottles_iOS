//
//  SceneDelegate.swift
//  Bottle
//
//  Created by 임현규 on 8/20/24.
//

import SwiftUI

import Feature

import ComposableArchitecture

final class SceneDelegate: UIResponder, UISceneDelegate {
  var store = Store(
    initialState: AppFeature.State(),
    reducer: { AppFeature() }
  )
  
  func sceneDidBecomeActive(_ scene: UIScene) {
    store.send(.sceneDelegate(.didBecomeActive))
  }
}
