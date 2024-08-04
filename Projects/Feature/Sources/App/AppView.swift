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
        if let tabViewStore = store.scope(state: \.tabView, action: \.tabView) {
          MainTabView(store: tabViewStore)
        } else if let loginStore = store.scope(state: \.login, action: \.login) {
          LoginView(store: loginStore)
        } else {
          // TODO: - Splash Image로 수정
          Text("로딩 중...")
        }
      }
      .onAppear {
        store.send(.onAppear)
      }
    }
  }
}
