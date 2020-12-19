//
//  LoginViewModel.swift
//  TDD
//
//  Created by Ahmed Ramy on 19/12/2020.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

public class LoginViewModel {
  
  public var validationErrors: [ValidationError] = []
  
  func login(email: String, password: String) {
    if email.isEmpty {
      validationErrors.append(.emailIsEmpty)
    }
  }
}
