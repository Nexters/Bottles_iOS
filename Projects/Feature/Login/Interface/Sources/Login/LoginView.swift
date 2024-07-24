//
//  LoginView.swift
//  FeatureLogin
//
//  Created by JongHoon on 7/25/24.
//

import SwiftUI

import ComposableArchitecture

public struct LoginView: View {
  let store: StoreOf<LoginFeature>
  
  public init(store: StoreOf<LoginFeature>) {
    self.store = store
  }
  
  public var body: some View {
    Text("login view")
  }
}

