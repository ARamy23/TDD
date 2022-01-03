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
  
  let network: NetworkProtocol
  
  init(network: NetworkProtocol) {
    self.network = network
  }
  
  public var onError: (([Error]) -> Void)?
  
  func login(email: String, password: String) {
    if email.isEmpty {
      validationErrors.append(.emailIsEmpty)
    }
    
    guard validationErrors.isEmpty else {
      onError?(validationErrors)
      return
    }
    
    self.validationErrors.removeAll()
    self.networkErrors.removeAll()
    
    network.call(
      api: AuthEndpoint.login(email: email, password: password),
      expected: User.self) { results in
        switch results {
        case let .success(user):
          print(user)
        case let .failure(error):
          self.networkErrors.append(error)
        }
      }
  }
}
