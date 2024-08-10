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
        reducer: { BottleStorageFeature()._printChanges() }
      ))
      .onAppear {
        AuthClient.liveValue.saveToken(token: .init(
          accessToken: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwiaWF0IjoxNzIzMTE3ODk1LCJleHAiOjE3MjMxNTM4OTV9.HjjnS1onaAUA6nJGOV-f6FE55eAihUGTFNYGmmyETQc",
          refershToken: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwiaWF0IjoxNzIzMTE3ODk1LCJleHAiOjE3Mzc2MzMwOTV9.Af-L2h_5pBQWrZCc1OQI3tm1DGwowqCAId-rK5vAPaQ"
        ))
      }
    }
  }
}

