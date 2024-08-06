//
//  PassthroughWindow.swift
//  DesignSystemExample
//
//  Created by JongHoon on 8/4/24.
//

import UIKit

class PassthroughWindow: UIWindow {
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    guard let view = super.hitTest(point, with: event)
    else {
      return nil
    }
    return rootViewController?.view == view ? nil : view
  }
}
