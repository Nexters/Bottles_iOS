//
//  BottleStorageView.swift
//  FeatureBottleStorage
//
//  Created by JongHoon on 7/25/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct BottleStorageView: View {
  @Perception.Bindable private var store: StoreOf<BottleStorageFeature>
  
  public init(store: StoreOf<BottleStorageFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      NavigationStack {
        VStack(spacing: 0.0) {
          bottleActiveStateSelectTab
          
          Spacer()
        }
      }
    }
  }
}

// MARK: - Private Views

private extension BottleStorageView {
  var bottleActiveStateSelectTab: some View {
    HStack(spacing: .xs) {
      OutlinedStyleButton(
        .small(contentType: .text),
        title: BottleActiveState.active.title,
        buttonType: .throttle,
        isSelected: store.selectedActiveStateTab == BottleActiveState.active,
        action: {
          store.send(.bottleActiveStateTabButtonTapped(.active))
        }
      )
      
      OutlinedStyleButton(
        .small(contentType: .text),
        title: BottleActiveState.done.title,
        buttonType: .throttle,
        isSelected: store.selectedActiveStateTab == BottleActiveState.done,
        action: {
          store.send(.bottleActiveStateTabButtonTapped(.done))
        }
      )
      
      Spacer()
    }
    .padding(.md)
    .padding(.top, 48.0)
  }
}
