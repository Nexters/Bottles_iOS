//
//  DomainError.swift
//  DomainError
//
//  Created by JongHoon on 9/11/24.
//

import Foundation

public enum DomainError: Error {
  public enum AuthError: Error {
    case invalidAppVersion
  }
  
  case unknown(_ message: String? = nil)
}
