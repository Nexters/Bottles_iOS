//
//  Source.swift
//  FeatureBottleStorageExample
//
//  Created by JongHoon on 7/24/24.
//

import SwiftUI

import FeatureBottleStorageInterface
import DomainAuth
import DomainAuthInterface

import ComposableArchitecture

@main
struct AppView: App {
  var body: some Scene {
    WindowGroup {
      BottleStorageView(store: Store(
        initialState: BottleStorageFeature.State(),
        reducer: { BottleStorageFeature() }
      ))
    }
  }
}

