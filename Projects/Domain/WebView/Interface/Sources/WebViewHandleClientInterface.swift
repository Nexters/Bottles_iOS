//
//  WebViewHandleClientInterface.swift
//  CoreWebViewInterface
//
//  Created by JongHoon on 8/3/24.
//

import Foundation

import CoreWebViewInterface

import Dependencies

public struct WebViewClient {
  private let messageToAction: (_ message: Any) throws -> BottleWebViewAction
  
  public init(
    messageToAction: @escaping (_: Any) throws -> BottleWebViewAction
  ) {
    self.messageToAction = messageToAction
  }
  
  public let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
  }()
  
  public func messageToAction(with message: Any) throws -> BottleWebViewAction {
    try messageToAction(message)
  }
}
