//
//  ProfileSetupView.swift
//  FeatureProfileSetupInterface
//
//  Created by 임현규 on 8/5/24.
//

import SwiftUI

import SharedDesignSystem
import CoreLoggerInterface

import ComposableArchitecture

public struct ProfileSetupView: View {
  @Perception.Bindable private var store: StoreOf<ProfileSetupFeature>
  
  public init(store: StoreOf<ProfileSetupFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
        EmptyView()
      } destination: { store in
        WithPerceptionTracking {
          switch store.state {
          case .IntroductionSetup:
            IntroductionSetupView(
              store: store.scope(
                state: \.IntroductionSetup,
                action: \.IntroductionSetup
              )
            )
          case .ProfileImageUpload:
            ProfileImageUploadView(
              store: store.scope(
                state: \.ProfileImageUpload,
                action: \.ProfileImageUpload
              )
            )
          }
        }
      }
      .onAppear {
        store.send(.onAppear)
      }
    }
  }
}
