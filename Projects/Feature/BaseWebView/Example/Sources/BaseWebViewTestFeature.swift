//
//  BaseWebViewTestFeature.swift
//  FeatureBaseWebViewExample
//
//  Created by 임현규 on 9/29/24.
//

import Foundation

import FeatureBaseWebViewInterface
import CoreWebViewInterface
import CoreKeyChainStore
import ComposableArchitecture

@Reducer
public struct BaseWebViewTestFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    var urlPath: String
    var webViewResource: CustomWebViewResource
    
    public init(urlPath: String) {
      self.urlPath = urlPath
      self.webViewResource = CustomWebViewResource(path: urlPath)
    }
  }
  
  public enum Action {
    case closeWebView
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}

extension BaseWebViewTestFeature {
  public init() {
    @Dependency(\.dismiss) var dismiss
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .closeWebView:
        return .run { send in
          await dismiss()
        }
      }
    }
    
    self.init(reducer: reducer)
  }
}

struct CustomWebViewResource: WebResourceProtocol, Equatable {
  var url: URL {
    return makeUrlWithToken(path)
  }
  
  var messageHandler: WebViewMessageHandler {
    return .default
  }
  
  var baseURL: String {
    return (Bundle.main.infoDictionary?["WEB_VIEW_BASE_URL"] as? String) ?? ""
  }
  
  var path: String
  
  init(path: String) {
    self.path = path
  }
}
