//
//  HasMinimum.swift
//  TDD
//
//  Created by Ahmed Ramy on 12/03/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import Foundation

public protocol HasMinimum {
  var field: BusinessConfigurations.Validation.Field { get }
  func validateMinimum() throws
}

public extension HasMinimum where Self: ValidationRule {
  func validateMinimum() throws {
    guard value.count >= field.minMax.min else {
      throw ValidationError
        .tooShort(
          field
        )
    }
  }
}
