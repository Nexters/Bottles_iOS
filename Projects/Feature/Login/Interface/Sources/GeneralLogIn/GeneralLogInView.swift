//
//  GeneralLogInView.swift
//  FeatureLoginInterface
//
//  Created by JongHoon on 8/4/24.
//

import SwiftUI

import FeatureBaseWebViewInterface

import ComposableArchitecture

public struct GeneralLogInView: View {
  private let store: StoreOf<GeneralLogInFeature>
  
  public init(store: StoreOf<GeneralLogInFeature>) {
    self.store = store
  }
  
  public var body: some View {
    BaseWebView(
      type: .login,
      actionDidInputted: { action in
        switch action {
        case let .showTaost(message):
          store.send(.presentToastDidRequired(message: message))
        case let .loginDidCompleted(accessToken, refreshToken):
          store.send(.loginDidCompleted(
            accessToken: accessToken,
            refreshToken: refreshToken
          ))
        default:
          break
        }
      }
    )
  }
}
