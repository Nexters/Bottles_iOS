//
//  WebViewMessageHandler.swift
//  CoreUtilInterface
//
//  Created by JongHoon on 8/3/24.
//

import Foundation

public enum WebViewMessageHandler {
  case `default`
  
  public var name: String {
    switch self {
    case .default:
      return (Bundle.main.infoDictionary?["WEB_VIEW_MESSAGE_HANDLER_DEFAULT_NAME"] as? String) ?? ""
    }
  }
}
