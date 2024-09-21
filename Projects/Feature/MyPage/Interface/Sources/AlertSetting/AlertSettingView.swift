//
//  AlertSettingView.swift
//  FeatureMyPageInterface
//
//  Created by 임현규 on 9/21/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct AlertSettingView: View {
  private let store: StoreOf<AlertSettingFeature>
  
  public init(store: StoreOf<AlertSettingFeature>) {
    self.store = store
  }
  
  public var body: some View {
    EmptyView()
  }
}
