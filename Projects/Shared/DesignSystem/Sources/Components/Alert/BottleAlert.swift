//
//  BottleAlert.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 9/14/24.
//

import SwiftUI
import ComposableArchitecture

private struct BottleAlertView<A, M, T>: View where A: View, M: View {
  private let title: Text
  private var isPresented: Binding<Bool>
  private let presenting: T?
  private let actions: (T) -> A
  private let message: (T) -> M
  
  public init(
    _ title: Text,
    isPresented: Binding<Bool>,
    presenting: T?,
    @ViewBuilder actions: @escaping (T) -> A,
    @ViewBuilder message: @escaping (T) -> M
  ) {
    self.title = title
    self.isPresented = isPresented
    self.presenting = presenting
    self.actions = actions
    self.message = message
  }
  
  var body: some View {
    EmptyView()
  }
}

extension View {
  public func BottleAlert<Action>(_ item: Binding<Store<AlertState<Action>, Action>?>) -> some View {
    
    let store = item.wrappedValue
    let alertState = store?.withState { $0 }
    
    return BottleAlertView(
      (alertState?.title).map { Text($0).font(to: .wantedSans(.subTitle1)) }
      ?? Text(verbatim: ""),
      isPresented: item.isPresent(),
      presenting: alertState,
      actions: { alertState in
        ForEach(alertState.buttons) { button in
          Button(role: button.role.map(ButtonRole.init)) {
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
          } label: {
            Text(button.label)
              .font(to: .wantedSans(.body))

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
