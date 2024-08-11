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
  @State private var isVisibleTabBar: Bool = false
  private let store: StoreOf<SandBeachFeature>
  
  public init(store: StoreOf<SandBeachFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      GeometryReader { geo in
        WithPerceptionTracking {
          if store.userState == .none && store.isLoading {
            LoadingIndicator()
          } else {
            VStack(spacing: 0) {
              Spacer()
              BottleImageView(type: .local(bottleImageSystem: .illustraition(.logo)))
                .frame(width: 78.06, height: 20)
                .padding(.top, geo.safeAreaInsets.top + 14)
                .padding(.bottom, 38)
              
              WantedSansStyleText(
                store.userState.title, style: .title1, color: .secondary)
              .frame(height: 62)
              .multilineTextAlignment(.center)
              .padding(.bottom, 24)
              Spacer()
              
              popup
                .padding(.bottom, 8)
              
              BottleImageView(type: .local(
                bottleImageSystem:
                  store.userState.isEmptyBottle ? .illustraition(.islandEmptyBottle) : .illustraition(.islandHasBottle))
              )
              .frame(width: geo.size.width)
              .frame(height: geo.size.width)
              .asThrottleButton {
                if store.userState.isHasNewBottle {
                  store.send(.newBottleIslandDidTapped)
                }
                
                if store.userState.isHasActiveBottle {
                  store.send(.bottleStorageIslandDidTapped)
                }
              }
              .disabled(store.isDisableIslandBottle)
              
              Spacer()
            }
          }
        }
      }
      .onAppear {
        isVisibleTabBar = true
        store.send(.onAppear)
      }
      .background {
        BottleImageView(
          type: .local(bottleImageSystem: .illustraition(.sandBeachBackground))
        )
      }
    }
    .toolbar(isVisibleTabBar ? .visible : .hidden, for: .tabBar)
    .animation(.easeInOut, value: isVisibleTabBar)
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
    case .hasNewBottle(let count):
      PopupView(
        popupType: .text(content: userState.popUpText)
      )
      .overlay(alignment: .topTrailing) {
        CountLabel(text: "\(count)")
          .offset(y: -12)
      }
    case .hasActiveBottle:
      PopupView(
        popupType: .text(content: userState.popUpText)
      )
    default:
      EmptyView()
    }
  }
}

