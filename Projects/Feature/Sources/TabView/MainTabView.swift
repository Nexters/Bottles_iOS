//
//  MainTabView.swift
//  AppManifests
//
//  Created by JongHoon on 7/22/24.
//

import SwiftUI

import ComposableArchitecture

public struct MainTabView: View {
  private let store: StoreOf<MainTabViewFeature>
  
  public init(store: StoreOf<MainTabViewFeature>) {
    self.store = store
  }
  
  public var body: some View {
    Text("Main Tab View")
  }
}
