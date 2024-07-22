//
//  BottleTabView.swift
//  AppManifests
//
//  Created by JongHoon on 7/22/24.
//

import SwiftUI

import ComposableArchitecture

public struct BottleTabView: View {
  private let store: StoreOf<BottleTabViewFeature>
  
  public init(store: StoreOf<BottleTabViewFeature>) {
    self.store = store
  }
  
  public var body: some View {
    Text("바디입니다.")
  }
}
