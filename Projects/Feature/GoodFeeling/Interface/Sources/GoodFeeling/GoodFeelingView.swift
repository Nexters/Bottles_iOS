//
//  GoodFeelingView.swift
//  FeatureGoodFeelingInterface
//
//  Created by JongHoon on 10/6/24.
//

import SwiftUI

import FeatureBaseWebViewInterface

import ComposableArchitecture

public struct GoodFeelingView: View {
  @Perception.Bindable private var store: StoreOf<GoodFeelingFeature>
  
  public init(store: StoreOf<GoodFeelingFeature>) { 
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      BaseWebView(
        type: .goodFeeling,
        actionDidInputted: { action in
          // TODO: action handling
        }
      )
    }
  }
}
