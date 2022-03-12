//
//  IsMandatory.swift
//  TDD
//
//  Created by Ahmed Ramy on 12/03/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import Foundation

public protocol IsMandatory {
  var field: BusinessConfigurations.Validation.Field { get }
  func validateIsEmpty() throws
}

public extension IsMandatory where Self: ValidationRule {
  func validateIsEmpty() throws {
    guard value.isEmpty == false else {
      throw ValidationError.empty(field)
    }
  }
}
