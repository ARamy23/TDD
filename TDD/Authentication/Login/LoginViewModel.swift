//
//  LoginViewModel.swift
//  TDD
//
//  Created by Ahmed Ramy on 19/12/2020.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Business
import Entity
import Combine

struct User: Codable {
  let name: String
}

public class LoginViewModel {
  var state: CurrentValueSubject<State, Never> = .init(.idle)
  
  var cancellables = Set<AnyCancellable>()
  var router: RouterProtocol
  
  init(router: RouterProtocol) {
    self.router = router
  }
  
  public func login(email: String, password: String) {
    validate(email, password)
    
    guard state.value.errors.isEmpty else { return }
    
    ServiceLocator.main.network.call(
      api: AuthEndpoint.login(email: email, password: password),
      model: AccessToken.self
    ).sink(receiveCompletion: { onComplete in
      guard case let .failure(error) = onComplete else { return }
      self.state.send(.failure([error.toOError()]))
    }, receiveValue: { token in
      try? ServiceLocator.main.cache.save(value: token, for: .accessToken)
    }).store(in: &cancellables)
  }
}

extension LoginViewModel {
  enum `State`: Equatable {
    case idle
    case loading
    case loaded(String)
    case failure([OError])
    
    var errors: [OError] {
      switch self {
        case let .failure(errors):
          return errors
        default:
          return []
      }
    }
    
    static func == (lhs: LoginViewModel.State, rhs: LoginViewModel.State) -> Bool {
      switch (lhs, rhs) {
        case (.idle, .idle):
          return true
        case (.loading, .loading):
          return true
        case let (.loaded(status1), .loaded(status2)):
          return status1 == status2
        case let (.failure(errors1), .failure(errors2)):
          return errors1 == errors2
        default:
          return false
      }
    }
  }
}

private extension LoginViewModel {
  func validate(_ email: String, _ password: String) {
    var errors: [OError] = []
    do {
      try EmailValidationRule(value: email).validate()
    } catch {
      errors.append(OErrorParser().parse(error))
    }
    
    do {
      try PasswordValidationRule(value: password).validate()
    } catch {
      errors.append(OErrorParser().parse(error))
    }
    
    guard !errors.isEmpty else { return }
    state.send(.failure(errors))
    router.alertWithAction(
      title: "Validation Errors",
      message: errors.map { $0.text }.joined(separator: "\n"),
      alertStyle: .actionSheet,
      actions: [
        (title: "Ok", style: .default, action: { })
      ]
    )
  }
}
