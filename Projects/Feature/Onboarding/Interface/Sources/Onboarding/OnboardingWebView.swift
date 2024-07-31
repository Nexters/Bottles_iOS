//
//  OnboardingWebView.swift
//  FeatureOnboardingInterface
//
//  Created by JongHoon on 7/31/24.
//

import SwiftUI
import WebKit

import ComposableArchitecture

internal struct OnboardingWebView: UIViewRepresentable {
  private var store: StoreOf<OnboardingFeature>
  private var webView: WKWebView?
  
  init(
    store: StoreOf<OnboardingFeature>
  ) {
    self.store = store
    let preferences = WKPreferences()
    preferences.javaScriptCanOpenWindowsAutomatically = true
    let configuration = WKWebViewConfiguration()
    configuration.preferences = preferences
    webView = WKWebView(frame: .zero, configuration: configuration)
  }
  
  func makeUIView(context: Context) -> WKWebView {
    webView?.navigationDelegate = context.coordinator
    return webView ?? WKWebView()
  }
  
  func updateUIView(_ uiView: WKWebView, context: Context) {
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(parent: self)
  }
  
  final class Coordinator: NSObject, WKNavigationDelegate {
    private let parent: OnboardingWebView
    
    init(parent: OnboardingWebView) {
      self.parent = parent
    }
  }
}
