//
//  OnboardingView.swift
//  FeatureOnboarding
//
//  Created by JongHoon on 7/31/24.
//

import SwiftUI
import WebKit

import ComposableArchitecture

public struct OnboardingView: View {
  private var store: StoreOf<OnboardingFeature>
  
  public init(store: StoreOf<OnboardingFeature>) {
    self.store = store
  }
  
  public var body: some View {
      OnboardingWebView(store: store)
      .ignoresSafeArea()
  }
}
