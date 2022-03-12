//
//  HasMaximum.swift
//  TDD
//
//  Created by Ahmed Ramy on 12/03/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import Foundation

public protocol HasMaximum {
  var field: BusinessConfigurations.Validation.Field { get }
  func validateMaximum() throws
}

public extension HasMaximum where Self: ValidationRule {
  func validateMaximum() throws {
    guard value.count <= field.minMax.max else {
      throw ValidationError.tooLong(
        field
      )
    }
  }
}
