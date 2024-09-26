//
//  UserError.swift
//  DomainUserInterface
//
//  Created by JongHoon on 9/22/24.
//

import Foundation

public enum UserError: Error {
  case requestContactsAccessAuthorityFailed
  case contactsAccessDenied
}
