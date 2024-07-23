//
//  AppView.swift
//  Feature
//
//  Created by JongHoon on 7/23/24.
//

import SwiftUI

import ComposableArchitecture

public struct AppView: View {
  private let store: StoreOf<AppFeature>
  
  public init(store: StoreOf<AppFeature>) {
    self.store = store
  }
  
  public var body: some View {
    Group {
      EmptyView()
    }
  }
}
