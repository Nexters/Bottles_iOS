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
    
    if let dict = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] {
      guard let type = dict["type"],
            let action = BottleWebViewAction(
              type: type as? String ?? "",
              message: dict["message"] as? String ?? "",
              accessToken: dict["accessToken"] as? String ?? "",
              refreshToken: dict["refreshToken"] as? String ?? "",
              url: dict["url"] as? String ?? "",
              isCompletedOnboardingIntroduction: dict["hasCompleteIntroduction"] as? Bool ?? false
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

