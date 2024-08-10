//
//  IntroductionView.swift
//  FeatureBottleStorage
//
//  Created by JongHoon on 8/11/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct IntroductionView: View {
  @Perception.Bindable private var store: StoreOf<IntroductionFeature>
  
  public init(store: StoreOf<IntroductionFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      ScrollView {
        VStack(alignment: .leading, spacing: 0.0) {
            
          
          Text("Introduction")
            .frame(height: 200.0)
          Text("Introduction")
            .frame(height: 200.0)
          Text("Introduction")
            .frame(height: 200.0)
          Text("Introduction")
            .frame(height: 200.0)
          Text("Introduction")
            .frame(height: 200.0)
          Text("Introduction")
            .frame(height: 200.0)
          Text("Introduction")
            .frame(height: 200.0)
          Text("Introduction")
            .frame(height: 200.0)
          Text("Introduction")
            .frame(height: 200.0)
          Text("Introduction")
            .frame(height: 200.0)
          Text("Introduction")
            .frame(height: 200.0)
        }
        .frame(maxWidth: .infinity)
      }
    }
  }
}
