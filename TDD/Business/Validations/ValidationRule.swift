//
//  ValidationRule.swift
//  TDD
//
//  Created by Ahmed Ramy on 12/03/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import Foundation

public protocol ValidationRule {
  var value: String { get set }
  func validate() throws
}
