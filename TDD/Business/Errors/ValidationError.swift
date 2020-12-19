//
//  ValidationError.swift
//  TDD
//
//  Created by Ahmed Ramy on 19/12/2020.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

public enum ValidationError: Error {
  case emailIsEmpty
}

extension ValidationError: LocalizedError {
  
  public var errorDescription: String? {
    switch self {
    case .emailIsEmpty:
      return "Email can't be empty"
    }
  }
}
