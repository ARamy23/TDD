//
//  PasswordValidationRule.swift
//  TDD
//
//  Created by Ahmed Ramy on 12/03/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import Foundation

public struct PasswordValidationRule: ValidationRule, IsMandatory, HasMinimum, HasMaximum {
  public var field: BusinessConfigurations.Validation.Field = .password
  
  public var value: String
  
  public init(value: String = "") {
    self.value = value
  }
  
  public func validate() throws {
    try validateIsEmpty()
    try validateMinimum()
    try validateMaximum()
  }
}
