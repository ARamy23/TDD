//
//  LoginViewModel.swift
//  TDD
//
//  Created by Ahmed Ramy on 19/12/2020.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

struct User: Codable {
  let name: String
}

public class LoginViewModel {
  
  public var validationErrors: [ValidationError] = []
  public var networkErrors: [NetworkError] = []
  
  public var onError: (([Error]) -> Void)?
  
  func login(email: String, password: String) {
    validate(email, password)
    
    guard validationErrors.isEmpty else {
      onError?(validationErrors)
      return
    }
    
    self.validationErrors.removeAll()
    self.networkErrors.removeAll()
    
    ServiceLocator.main.network.call(
      api: AuthEndpoint.login(email: email, password: password),
      expected: AccessToken.self
    ) { results in
      switch results {
        case let .success(accessToken):
          ServiceLocator.main.cache.save(accessToken, for: .accessToken)
        case let .failure(error):
          self.networkErrors.append(error)
      }
    }
  }
}

private extension LoginViewModel {
  func validate(_ email: String, _ password: String) {
    do {
      try EmailValidationRule(value: email).validate()
      try PasswordValidationRule(value: password).validate()
    } catch let error as ValidationError {
      self.validationErrors.append(error)
    } catch {
      print(error)
    }
  }
}
