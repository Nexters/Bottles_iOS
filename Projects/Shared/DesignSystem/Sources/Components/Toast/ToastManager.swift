//
//  ToastManager.swift
//  DesignSystemExample
//
//  Created by JongHoon on 8/4/24.
//

import Foundation

public class ToastManager: ObservableObject {
  public static let shared = ToastManager()
  @Published var toasts: [ToastItem] = []
  
  public func present(
    message: String,
    isUserInteractionEnable: Bool = false,
    durationSecond: Double
  ) {
    toasts.append(.init(
      message: message,
      durationSecond: durationSecond
    ))
  }
}
