//
//  BottleAlert.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 9/14/24.
//

import SwiftUI
import ComposableArchitecture

extension View {
  public func bottleAlert<Action>(_ item: Binding<Store<AlertState<Action>, Action>?>) -> some View {
    
    let store = item.wrappedValue
    let alertState = store?.withState { $0 }
    let isPresented = Binding<Bool>(
      get: { item.wrappedValue != nil },
      set: { newValue in
        if !newValue {
          item.wrappedValue = nil
        }
      }
    )
    
    return ZStack {
      self
      BottleAlertView(
        (alertState?.title).map { Text($0).font(to: .wantedSans(.subTitle1)) }
        ?? Text(verbatim: ""),
        isPresented: isPresented,
        presenting: alertState,
        actions: { alertState in
          HStack(spacing: .sm) {
            ForEach(alertState.buttons) { button in
              Text(button.label)
                .font(to: .wantedSans(.body))
                .asButton {
                  switch button.action.type {
                  case let .send(action):
                    if let action {
                      store?.send(action)
                    }
                  case let .animatedSend(action, animation):
                    if let action {
                      store?.send(action, animation: animation)
                    }
                  }
                }
                .buttonStyle(
                  SolidButtonStyle(
                    sizeType: .small,
                    buttonApperance: button.role == .cancel ? .cancel : .solid
                  )
                )
            }
          }
        },
        message: {
          $0.message.map(Text.init)
            .font(to: .wantedSans(.body))
        }
      )
    }
  }
}
