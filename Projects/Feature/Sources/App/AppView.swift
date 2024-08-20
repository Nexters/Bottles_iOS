//
//  AppView.swift
//  Feature
//
//  Created by JongHoon on 7/23/24.
//

import SwiftUI

import FeatureLoginInterface
import FeatureOnboardingInterface

import ComposableArchitecture

public struct AppView: View {
  @Environment(\.scenePhase) private var scenePhase
  
  private let store: StoreOf<AppFeature>

  public init(store: StoreOf<AppFeature>) {
    self.store = store
  }
  
  public var body: some View {
    Group {
      WithPerceptionTracking {
        if let tabViewStore = store.scope(state: \.mainTab, action: \.mainTab) {
          MainTabView(store: tabViewStore)
        } else if let loginStore = store.scope(state: \.login, action: \.login) {
          LoginView(store: loginStore)
        } else if let onboardingStore = store.scope(state: \.onboarding, action: \.onboarding) {
          OnboardingView(store: onboardingStore)
        } else {
          SplashView()
        }
      }
      .onAppear {
        store.send(.onAppear)
      }
      .onChange(of: scenePhase) { newValue in
        if newValue == .active {
          store.send(.sceneDidActive)
        }
      }
    }
  }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
