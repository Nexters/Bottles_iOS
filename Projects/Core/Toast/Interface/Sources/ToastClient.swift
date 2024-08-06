//
//  ToastClient.swift
//  CoreToast
//
//  Created by JongHoon on 8/4/24.
//

import Foundation

import SharedDesignSystem

import Dependencies

public struct ToastClient {
  private let _presentToast: (_ message: String, _ durationSecond: Double) -> Void
  
  public init(presentToast: @escaping (_ message: String, _ durationSecond: Double) -> Void) {
    self._presentToast = presentToast
  }
  
  public func presentToast(message: String, durationSecond: Double = 2.0) {
    _presentToast(message, durationSecond)
  }
}

extension ToastClient: DependencyKey {
  public static var liveValue: ToastClient {
    return .init(
      presentToast: { message, duration in
        ToastManager.shared.present(
          message: message,
          durationSecond: duration
        )
      }
    )
  }
}

extension DependencyValues {
  public var toastClient: ToastClient {
    get { self[ToastClient.self] }
    set { self[ToastClient.self] = newValue }
  }
}
