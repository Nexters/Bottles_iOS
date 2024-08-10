//
//  QuestionAndAnswerView.swift
//  FeatureBottleStorage
//
//  Created by JongHoon on 8/11/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct QuestionAndAnswerView: View {
  @Perception.Bindable private var store: StoreOf<QuestionAndAnswerFeature>
  
  public init(store: StoreOf<QuestionAndAnswerFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      ScrollView {
        VStack(alignment: .leading, spacing: 0.0) {
          Text("가치관 문답")
        }
        .frame(maxWidth: .infinity)
      }
    }
  }
}
