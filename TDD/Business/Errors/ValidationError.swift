//
//  ValidationError.swift
//  TDD
//
//  Created by Ahmed Ramy on 19/12/2020.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

public enum ValidationError: Error {
  case empty(BusinessConfigurations.Validation.Field)
}

extension ValidationError: LocalizedError {
  
  public var errorDescription: String? {
    switch self {
    case let .empty(field):
      return "\(field.title) can't be empty"
    }
  }
}

extension ValidationError: Equatable { }
