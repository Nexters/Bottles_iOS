//
//  SplashView.swift
//  Feature
//
//  Created by 임현규 on 8/12/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct SplashView: View {
  @Perception.Bindable private var store: StoreOf<SplashFeature>
  
  public init(store: StoreOf<SplashFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      ZStack {
        ColorToken.container(.pressed).color
          .ignoresSafeArea()
        
        Image.BottleImageSystem.illustraition(.splash).image
      }
      .bottleAlert($store.scope(state: \.destination?.alert, action: \.destination.alert))
      .ignoresSafeArea()
      .task {
        store.send(.onAppear)
      }
    }
  }
}
