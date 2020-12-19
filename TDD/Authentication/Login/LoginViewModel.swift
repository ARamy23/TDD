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
  
  public var onError: (([Error]) -> Void)?
  
  func login(email: String, password: String) {
    if email.isEmpty {
      validationErrors.append(.emailIsEmpty)
    }
    
    guard validationErrors.isEmpty else {
      onError?(validationErrors)
      validationErrors.removeAll()
      return
    }
    // Do actual login here
  }
}
