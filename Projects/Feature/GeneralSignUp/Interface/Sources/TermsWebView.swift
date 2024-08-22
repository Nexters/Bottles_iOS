//
//  TermsWebView.swift
//  FeatureGeneralSignUpInterface
//
//  Created by JongHoon on 8/13/24.
//

import SwiftUI
import WebKit

public struct TermsWebView: UIViewRepresentable {
  private let webView: WKWebView
  private let url: String
  
  public init(
    url: String
  ) {
    self.url = url
    let preferences = WKPreferences()
    preferences.javaScriptCanOpenWindowsAutomatically = true
    let configuration = WKWebViewConfiguration()
    configuration.preferences = preferences
    configuration.defaultWebpagePreferences.allowsContentJavaScript = true
    webView = WKWebView(frame: .zero, configuration: configuration)
  }
  
  public func makeUIView(context: Context) -> WKWebView {
    webView.navigationDelegate = context.coordinator
    let request = URLRequest(url: URL(string: url)!)
    webView.load(request)
    return webView
  }
  
  public func updateUIView(_ uiView: WKWebView, context: Context) {
  }
  
  public func makeCoordinator() -> Coordinator {
    Coordinator(parent: self)
  }
  
  final public class Coordinator: NSObject, WKNavigationDelegate {
    private let parent: TermsWebView
    
    init(
      parent: TermsWebView
    ) {
      self.parent = parent
    }
    
    
    public func webView(
      _ webView: WKWebView,
      didFinish navigation: WKNavigation!
    ) {
      
    }
  }
}
