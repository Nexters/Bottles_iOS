//
//  AppView.swift
//  Feature
//
//  Created by JongHoon on 7/23/24.
//

import SwiftUI

import FeatureLogin
import FeatureLoginInterface

import ComposableArchitecture

public struct AppView: View {
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
        } else {
          SplashView()
        }
      }
      .onAppear {
        store.send(.onAppear)
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
