//
//  BottleAlertView.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 9/14/24.
//

import SwiftUI

struct BottleAlertView<A, M, T>: View where A: View, M: View {
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
    if isPresented.wrappedValue {
      ZStack {
        Color.black
          .opacity(0.5)
          .edgesIgnoringSafeArea(.all)
        
        VStack(spacing: 0) {
          alertImage
          title
            .padding(.bottom, 4)
          messageView
          actionsView
        }
        .padding(.horizontal, .md)
        .frame(maxWidth: 300)
        .background(to: ColorToken.container(.primary))
        .cornerRadius(12)
      }
    }
  }
}

private extension BottleAlertView {
  var alertImage: some View {
    BottleImageView(type: .local(bottleImageSystem: .icom(.siren)))
      .foregroundStyle(to: ColorToken.icon(.primary))
      .padding(.top, .lg)
      .padding(.bottom, .xs)
  }
  
  @ViewBuilder
  var messageView: some View {
    if let data = presenting {
      message(data)
        .multilineTextAlignment(.center)
        .padding(.bottom, .sm)
      
    } else {
      EmptyView()
    }
  }
  
  @ViewBuilder
  var actionsView: some View {
    if let data = presenting {
      actions(data)
        .padding(.top, .md)
        .padding(.bottom, .md)
    } else {
      EmptyView()
    }
  }
}
