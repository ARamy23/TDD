//
//  BusinessConfigurations.swift
//  TDD
//
//  Created by Ahmed Ramy on 07/01/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import Foundation

/// Represents Business Logic Configuration for easier changes whether global or specific changes
public enum BusinessConfigurations {
  public enum Validation {}
}

public extension BusinessConfigurations.Validation {
  enum Field {
    case email
    case password
    
    var minMax: (min: Int, max: Int) {
      switch self {
      case .email:
        return (0, 999)
      case .password:
        return (8, 32)
      }
    }
    
    var title: String {
      switch self {
      case .email:
        return "Email"
      case .password:
        return "Password"
      }
    }
  }
}

