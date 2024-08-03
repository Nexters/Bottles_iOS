//
//  WebViewClient.swift
//  CoreWebViewInterface
//
//  Created by JongHoon on 8/3/24.
//

import Foundation

import CoreWebViewInterface
import DomainWebViewInterface

import Dependencies

extension DependencyValues {
  public var webViewClient: WebViewClient {
    get { self[WebViewClient.self] }
    set { self[WebViewClient.self] = newValue }
  }
}

extension WebViewClient: DependencyKey {
  public static var liveValue: WebViewClient = WebViewClient { message in
    guard let message = message as? String,
          let jsonData = message.data(using: .utf8)
    else {
      // TODO: Domain error 로 수정
      throw NSError(domain: "unknown", code: 0)
    }
    
    if let dict = try JSONSerialization.jsonObject(with: jsonData) as? [String: String] {
      guard let type = dict["type"],
            let action = BottleWebViewAction(
              type: type,
              message: dict["message"],
              accessToken: dict["accessToken"],
              refreshToken: dict["refreshToken"]
            )
      else {
        throw NSError(domain: "unknown", code: 0)
      }
      return action
    } else {
      // TODO: Domain error 로 수정
      throw NSError(domain: "unknown", code: 0)
    }
  }
}

