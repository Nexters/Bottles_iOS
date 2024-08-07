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
      VStack(spacing: .sm) {
        Spacer()
        
        popup
        
        BottleImageView(type: .remote(
          url: store.imageURL,
          downsamplingWidth: 100,
          downsamplingHeight: 100)
        )
        .frame(width: 100, height: 100)
        .overlay(roundedRectangle)
        .padding(.bottom, 52)
      }
      .onAppear {
        store.send(.onAppear)
      }
    }
  }
}

// MARK: - Views

public extension SandBeachView {
  var roundedRectangle: some View  {
    RoundedRectangle(cornerRadius: BottleRadiusType.md.value)
      .strokeBorder(
        ColorToken.border(.primary).color,
        lineWidth: 1
      )
  }
  
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

