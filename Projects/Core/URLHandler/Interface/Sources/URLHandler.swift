//
//  URLHandler.swift
//  CoreURLHandlerInterface
//
//  Created by JongHoon on 9/20/24.
//

import UIKit

public final class URLHandler {
  
  public static let shared = URLHandler()
  
  private init() { }
  
  public func openURL(urlType: BottleURLType) {
    UIApplication.shared.open(urlType.url)
  }
}
