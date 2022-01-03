//
//  LoginEndpoint.swift
//  TDD
//
//  Created by Ahmed Ramy on 03/01/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import Foundation

enum AuthEndpoint {
  case login(email: String, password: String)
}

extension AuthEndpoint: Endpoint {
  var path: String {
    switch self {
    case .login:
      return "login"
    }
  }
  
  var parameters: HTTPParameters {
    switch self {
    case let .login(email, password):
      return [
        "email": email,
        "password": password
      ]
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .login:
      return .POST
    }
  }
}
