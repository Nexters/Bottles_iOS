//
//  SandBeachView.swift
//  FeatureSandBeach
//
//  Created by JongHoon on 7/25/24.
//

import SwiftUI

import ComposableArchitecture

public struct SandBeachView: View {
  let store: StoreOf<SandBeachFeature>
  
  public init(store: StoreOf<SandBeachFeature>) {
    self.store = store
  }
  
  public var body: some View {
    Text("Sand Beach view")
  }
}

