//
//  ToastItem.swift
//  DesignSystemExample
//
//  Created by JongHoon on 8/4/24.
//

import Foundation

public struct ToastItem: Identifiable {
  public let id: UUID = .init()
  public let message: String
  public let durationSecond: Double
  
  public init(
    message: String,
    durationSecond: Double = 2.0
  ) {
    self.message = message
    self.durationSecond = durationSecond
  }
}
