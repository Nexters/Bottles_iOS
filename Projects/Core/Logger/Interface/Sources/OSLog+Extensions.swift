//
//  OSLog+Extensions.swift
//  CoreLoggerInterface
//
//  Created by 임현규 on 7/23/24.
//

import Foundation
import OSLog

extension OSLog {
  static let subsystem = Bundle.main.bundleIdentifier ?? ""
}
