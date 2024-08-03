//
//  BottleWebViewAction.swift
//  CoreWebViewInterface
//
//  Created by JongHoon on 8/3/24.
//

public enum BottleWebViewAction: Equatable {
  case closeWebView
  case showTaost(mesage: String)
  case tokenDidSend(access: String, refresh: String)
  
  public init?(
    type: String,
    message: String? = nil,
    accessToken: String? = nil,
    refreshToken: String? = nil
  ) {
    switch type {
    case "onWebViewClose":
      self = .closeWebView
      
    case "onToastOpen":
      self = .showTaost(mesage: message ?? "")
      
    case "onTokenSend":
      self = .tokenDidSend(
        access: accessToken ?? "",
        refresh: refreshToken ?? ""
      )
      
    default:
      return nil
    }
  }
}
