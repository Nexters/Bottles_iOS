//
//  BottleWebView.swift
//  CoreWebViewInterface
//
//  Created by JongHoon on 8/3/24.
//

import SwiftUI
import WebKit

import CoreWebViewInterface
import DomainWebView

import ComposableArchitecture

public struct BaseWebView: UIViewRepresentable {
  private let webView: WKWebView
  private let type: BottleWebViewType
  private let isScrollEnabled: Bool
  private let actionDidInputted: ((BottleWebViewAction) -> Void)?
  
  public init(
    type: BottleWebViewType,
    isScrollEnabled: Bool = false,
    actionDidInputted: ((BottleWebViewAction) -> Void)? = nil
  ) {
    self.type = type
    self.isScrollEnabled = isScrollEnabled
    self.actionDidInputted = actionDidInputted
    let preferences = WKPreferences()
    preferences.javaScriptCanOpenWindowsAutomatically = true
    let configuration = WKWebViewConfiguration()
    configuration.preferences = preferences
    configuration.defaultWebpagePreferences.allowsContentJavaScript = true
    webView = WKWebView(frame: .zero, configuration: configuration)
  }
  
  public func makeUIView(context: Context) -> WKWebView {
    webView.configuration.userContentController.add(
      context.coordinator,
      name: type.messageHandler.name
    )
    webView.navigationDelegate = context.coordinator
    webView.scrollView.isScrollEnabled = isScrollEnabled
    
    let request = URLRequest(url: type.url)
    webView.load(request)
    return webView
  }
  
  public func updateUIView(_ uiView: WKWebView, context: Context) {
  }
  
  public func makeCoordinator() -> Coordinator {
    Coordinator(
      parent: self,
      actionDidInputted: actionDidInputted
    )
  }
  
  final public class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
    @Dependency(\.webViewClient) private var webViewClient
    private let parent: BaseWebView
    private let actionDidInputted: ((BottleWebViewAction) -> Void)?
    
    init(
      parent: BaseWebView,
      actionDidInputted: ((BottleWebViewAction) -> Void)?
    ) {
      self.parent = parent
      self.actionDidInputted = actionDidInputted
    }
    
    public func userContentController(
      _ userContentController: WKUserContentController,
      didReceive message: WKScriptMessage
    ) {
      guard message.name == WebViewMessageHandler.default.name
      else {
        return
      }
      let aciton = try? webViewClient.messageToAction(with: message.body)
    }
  }
}
