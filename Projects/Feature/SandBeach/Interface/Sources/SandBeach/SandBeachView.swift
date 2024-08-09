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
      ZStack {
        GeometryReader { geo in
          
          VStack(spacing: 0) {
            Spacer()
              
            BottleImageView(type: .local(bottleImageSystem: .illustraition(.logo)))
            
              .frame(width: 78.06, height: 20)
              .padding(.bottom, 32)

            WantedSansStyleText(
              "보틀에 오신 것을\n환영해요!", style: .title1, color: .secondary)
            .multilineTextAlignment(.center)
            .padding(.bottom ,32)

            popup
            
            
            BottleImageView(type: .local(bottleImageSystem: .illustraition(.islandEmptyBottle)))
              .frame(width: geo.size.width)
              .frame(height: geo.size.width)
              
            Spacer()
          }
        }
        
        .onAppear {
          store.send(.onAppear)
        }
        .zIndex(1)
        
        BottleImageView(type: .local(bottleImageSystem: .illustraition(.sandBeachBackground)))
          .scaledToFill()
          .frame(minWidth: 0) // 👈 This will keep other views (like a large text) in the frame
          .edgesIgnoringSafeArea(.all)
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

