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
  let cache: CacheProtocol
  
  init(
    network: NetworkProtocol,
    cache: CacheProtocol
  ) {
    self.network = network
    self.cache = cache
  }
  
  public var onError: (([Error]) -> Void)?
  
  func login(email: String, password: String) {
    validate(email, password)
    
    guard validationErrors.isEmpty else {
      onError?(validationErrors)
      return
    }
    
    self.validationErrors.removeAll()
    self.networkErrors.removeAll()
    
    network.call(
      api: AuthEndpoint.login(email: email, password: password),
      expected: AccessToken.self
    ) { results in
        switch results {
        case let .success(accessToken):
          self.cache.save(accessToken, for: .accessToken)
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

public protocol ValidationRule {
  var value: String { get set }
  func validate() throws
}

public protocol IsMandatory {
    var field: BusinessConfigurations.Validation.Field { get }
    func validateIsEmpty() throws
}

public extension IsMandatory where Self: ValidationRule {
    func validateIsEmpty() throws {
        guard value.isEmpty == false else {
            throw ValidationError.empty(field)
        }
    }
}

public protocol HasMinimum {
    var field: BusinessConfigurations.Validation.Field { get }
    func validateMinimum() throws
}

public protocol HasMaximum {
    var field: BusinessConfigurations.Validation.Field { get }
    func validateMaximum() throws
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

public extension HasMaximum where Self: ValidationRule {
    func validateMaximum() throws {
        guard value.count <= field.minMax.max else {
            throw ValidationError.tooLong(
                field
            )
        }
    }
}

public struct EmailValidationRule: ValidationRule, IsMandatory {
  public var field: BusinessConfigurations.Validation.Field = .email
  
  public var value: String
  
  public init(value: String = "") {
    self.value = value
  }
  
  public func validate() throws {
    try validateIsEmpty()
  }
}

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
