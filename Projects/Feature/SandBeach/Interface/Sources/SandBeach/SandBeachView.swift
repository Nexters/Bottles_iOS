//
//  SandBeachView.swift
//  FeatureSandBeach
//
//  Created by JongHoon on 7/25/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct SandBeachView: View {
  private let store: StoreOf<SandBeachFeature>
  
  public init(store: StoreOf<SandBeachFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      GeometryReader { geo in
        if store.isLoading {
          LoadingIndicator()
        } else {
          VStack(spacing: 0) {
            Spacer()
            BottleImageView(type: .local(bottleImageSystem: .illustraition(.logo)))
              .frame(width: 78.06, height: 20)
              .padding(.top, geo.safeAreaInsets.top + 14)
              .padding(.bottom, 38)
            
            WantedSansStyleText(
              "보틀에 오신 것을\n환영해요!", style: .title1, color: .secondary)
            .frame(height: 62)
            .multilineTextAlignment(.center)
            .padding(.bottom, 24)
            Spacer()
            
            popup
              .padding(.bottom, 8)
            
            BottleImageView(type: .local(bottleImageSystem: .illustraition(.islandEmptyBottle)))
              .frame(width: geo.size.width)
              .frame(height: geo.size.width)
            
            Spacer()
          }
        }
      }
      .onAppear {
        store.send(.onAppear)
      }
      .background {
        BottleImageView(
          type: .local(bottleImageSystem: .illustraition(.sandBeachBackground))
        )
      }
    }
    .edgesIgnoringSafeArea([.top, .bottom])
  }
}

// MARK: - Views

public extension SandBeachView {
  @ViewBuilder
  var popup: some View {
    let userState = store.userState
    
    switch userState {
    case .noIntroduction:
      PopupView(
        popupType: .button(
          content: userState.popUpText,
          buttonTitle: userState.buttonText ?? ""),
        action: { store.send(.writeButtonDidTapped) })
    case .noBottle:
      PopupView(
        popupType: .text(content: userState.popUpText)
      )
    case .hasBottle(let count):
      PopupView(
        popupType: .text(content: userState.popUpText)
      )
      .overlay(
        GeometryReader { geometry in
          CountLabel(text: "\(count)")
            .frame(width: geometry.size.width * 2)
            .frame(height: 0)
        }
      )
      .asButton(
        action: { store.send(.newBottlePopupDidTapped) })
    default:
      EmptyView()
    }
  }
}

