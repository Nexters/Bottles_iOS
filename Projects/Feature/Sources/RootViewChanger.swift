//
//  RootViewChanger.swift
//  CoreUtil
//
//  Created by JongHoon on 7/22/24.
//

import SwiftUI
import UIKit

import ComposableArchitecture

public struct RootViewChanger {
  public init() {
    
  }
  
  public func changeRootView(rootView: RootView) {
    DispatchQueue.main.async {
      let window = UIApplication
        .shared
        .connectedScenes
        .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
        .first { $0.isKeyWindow }
      guard let window
      else {
        fatalError("no window!")
      }
      
      let rootView = switch rootView {
      case .tabView:
        BottleTabView(store: Store(
          initialState: BottleTabViewFeature.State(),
          reducer: { BottleTabViewFeature() }
        ))
      }
      
      window.rootViewController = UIHostingController(rootView: rootView)
      window.makeKeyAndVisible()
      UIView.transition(
        with: window,
        duration: 0.3,
        options: [.transitionCrossDissolve],
        animations: nil,
        completion: nil
      )
    }
  }
}

public extension RootViewChanger {
  enum RootView {
    case tabView
  }
}
