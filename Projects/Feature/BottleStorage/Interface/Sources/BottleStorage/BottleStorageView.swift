//
//  BottleStorageView.swift
//  FeatureBottleStorage
//
//  Created by JongHoon on 7/25/24.
//

import SwiftUI

import ComposableArchitecture

public struct BottleStorageView: View {
  let store: StoreOf<BottleStorageFeature>
  
  public init(store: StoreOf<BottleStorageFeature>) {
    self.store = store
  }
  
  public var body: some View {
    Text("Bottle Storage View")
  }
}


