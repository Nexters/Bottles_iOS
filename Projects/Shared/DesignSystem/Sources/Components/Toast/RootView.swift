//
//  RootView.swift
//  DesignSystemExample
//
//  Created by JongHoon on 8/4/24.
//

import SwiftUI

public struct RootView<Content: View>: View {
  @ViewBuilder private var content: Content
  @State private var overlayWindow: UIWindow?
  
  public init(
    @ViewBuilder content: () -> Content,
    overlayWindow: UIWindow? = nil
  ) {
    self.content = content()
    self.overlayWindow = overlayWindow
  }
  
  public var body: some View {
    content
      .onAppear {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           overlayWindow == nil {
          let window = PassthroughWindow(windowScene: windowScene)
          let rootViewController = UIHostingController(rootView: ToastGroup())
          rootViewController.view.frame = windowScene.keyWindow?.frame ?? .zero
          rootViewController.view.backgroundColor = .clear
          window.rootViewController = rootViewController
          window.backgroundColor = .clear
          window.isHidden = false
          window.isUserInteractionEnabled = true
          window.tag = 2525
          overlayWindow = window
        }
      }
  }
}
