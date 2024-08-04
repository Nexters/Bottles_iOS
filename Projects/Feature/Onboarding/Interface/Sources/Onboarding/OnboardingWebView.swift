//
//  OnboardingWebView.swift
//  FeatureOnboardingInterface
//
//  Created by JongHoon on 7/31/24.
//

import SwiftUI
import WebKit

import CoreLoggerInterface
import CoreWebViewInterface

import ComposableArchitecture

internal struct OnboardingWebView: UIViewRepresentable {
  private var store: StoreOf<OnboardingFeature>
  private let webView: WKWebView
  
  init(
    store: StoreOf<OnboardingFeature>
  ) {
    self.store = store
    let preferences = WKPreferences()
    preferences.javaScriptCanOpenWindowsAutomatically = true
    let configuration = WKWebViewConfiguration()
    configuration.preferences = preferences
    configuration.defaultWebpagePreferences.allowsContentJavaScript = true
    webView = WKWebView(frame: .zero, configuration: configuration)
  }
  
  func makeUIView(context: Context) -> WKWebView {
    webView.configuration.userContentController.add(context.coordinator, name: WebViewMessageHandler.default.name)
    webView.navigationDelegate = context.coordinator
    webView.scrollView.isScrollEnabled = false
        
    let request = URLRequest(url: WebViewURL.createProfile.url)
    webView.load(request)
    
    return webView
  }
  
  func updateUIView(_ uiView: WKWebView, context: Context) {
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(parent: self)
  }
  
  final class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
    private let parent: OnboardingWebView
    
    init(parent: OnboardingWebView) {
      self.parent = parent
    }
    
    func userContentController(
      _ userContentController: WKUserContentController,
      didReceive message: WKScriptMessage
    ) {
      Log.debug(message.name)
      guard message.name == WebViewMessageHandler.default.name
      else {
        return
      }
      Log.debug("test!")
    }
  }
}
