//
//  MyPageView.swift
//  FeatureMyPageInterface
//
//  Created by JongHoon on 7/24/24.
//

import SwiftUI

import ComposableArchitecture

public struct MyPageView: View {
  let store: StoreOf<MyPageFeature>
  
  public init(store: StoreOf<MyPageFeature>) {
    self.store = store
  }
  
  public var body: some View {
    Text("My Page view")
  }
}
