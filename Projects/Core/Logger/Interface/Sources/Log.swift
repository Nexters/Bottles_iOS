//
//  Log.swift
//  CoreLoggerInterface
//
//  Created by 임현규 on 7/23/24.
//

import Foundation
import OSLog

public enum Log {
  public enum Level {
    case debug
    case info
    case error
    case fault
    
    fileprivate var category: String {
      switch self {
      case .debug:
        return "Debug"
      case .info:
        return "Info"
      case .error:
        return "Error"
      case .fault:
        return "Fault"
      }
    }
    
    fileprivate var osLogType: OSLogType {
      switch self {
      case .debug:
        return .debug
      case .info:
        return .info
      case .error:
        return .error
      case .fault:
        return .fault
      }
    }
  }
}

// MARK: - Private Method

private extension Log {
  static func log(message: Any?, level: Level, fileName: String, line: Int, funcName: StaticString) {
#if DEBUG
    let logger = Logger(subsystem: OSLog.subsystem, category: level.category)
    let moduleName = fileName.prefix(while: { $0 != "/" })
    let filename = fileName.components(separatedBy: "/").last ?? ""
    var logMessage = "[\(moduleName), \(filename), \(line), \(funcName)]"
    if let message = message {
      logMessage += " - \(message)"
    }
    switch level {
    case .debug:
      logger.debug("✨ \(logMessage, privacy: .public)")
    case .info:
      logger.info("ℹ️ \(logMessage, privacy: .public)")
    case .error:
      logger.error("🚨 \(logMessage, privacy: .public)")
    case .fault:
      logger.fault("‼️ \(logMessage, privacy: .public)")
    }
#endif
  }
  
  static func simpleLog(message: Any?, level: Level, fileName: String) {
    #if DEBUG
    let logger = Logger(subsystem: OSLog.subsystem, category: level.category)
    let moduleName = fileName.prefix(while: { $0 != "/" })

    var logMessage = "[\(moduleName)]"
    
    if let message = message {
        logMessage += " - \(message)"
    }
    
    switch level {
    case .debug:
      logger.debug("✨ \(logMessage, privacy: .public)")
    case .info:
      logger.info("ℹ️ \(logMessage, privacy: .public)")
    case .error:
      logger.error("🚨 \(logMessage, privacy: .public)")
    case .fault:
      logger.fault("‼️ \(logMessage, privacy: .public)")
    }
    
    #endif
  }
}

// MARK: - Public Methods

public extension Log {
  static func debug(_ message: Any?, fileName: String = #fileID, line: Int = #line, funcName: StaticString = #function) {
    log(message: message, level: .debug, fileName: fileName, line: line, funcName: funcName)
  }
  
  static func info(_ message: Any?, fileName: String = #fileID, line: Int = #line, funcName: StaticString = #function) {
    log(message: message, level: .info, fileName: fileName, line: line, funcName: funcName)
  }
  
  static func error(_ message: Any?, fileName: String = #fileID, line: Int = #line, funcName: StaticString = #function) {
    log(message: message, level: .error, fileName: fileName, line: line, funcName: funcName)
  }
  
  static func fault(_ message: Any?, fileName: String = #fileID, line: Int = #line, funcName: StaticString = #function) {
    log(message: message, level: .fault, fileName: fileName, line: line, funcName: funcName)
  }
  
  static func network(_ message: Any?, level: Level, fileName: String = #fileID) {
    simpleLog(message: message, level: level, fileName: fileName)
  }
}
