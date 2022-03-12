//
//  LoginViewModelTests.swift
//  TDDTests
//
//  Created by Ahmed Ramy on 19/12/2020.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import XCTest
@testable import Entity
@testable import Business
@testable import TDD

class LoginViewModelTests: XCTestCase {
  
  var network: FakeNetworkManager!
  var cache: FakeCache!
  var sut: LoginViewModel!
  
  override func setUp() {
    super.setUp()
    network = .init()
    cache = .init()
    
    ServiceLocator.main = .init(network: network, cache: cache)
    
    sut = .init()
  }
  
  override func tearDown() {
    super.tearDown()
    network = nil
    cache = nil
    sut = nil
  }
  
  func test_GivenEmptyEmail_WhenLogin_ShowError() {
    // Given
    let email = ""
    let password = ""
    
    // When
    sut.login(email: email, password: password)
    
    // Then
    XCTAssertEqual(
      sut.state.value,
      .failure([
        ValidationError.empty(.email).toOError(),
        ValidationError.empty(.password).toOError(),
      ])
    )
  }
  
  func test_GivenAnEmptyPassword_WhenLogin_ThrowsAnError() {
    // Given
    let email = "valid_email@gmail.com"
    let password = ""
    
    // When
    sut.login(email: email, password: password)
    
    // Then
    XCTAssertEqual(
      sut.state.value,
      .failure([
        ValidationError.empty(.password).toOError()
      ])
    )
  }
  
  func test_GivenUserPasswordIsShorterThanMinimum_WhenLogin_ErrorIsThrown() {
    // Given
    let email = "valid_email@gmail.com"
    let password = "123"
    
    // When
    sut.login(email: email, password: password)
    
    // Then
    XCTAssertEqual(
      sut.state.value,
      .failure([
        ValidationError.tooShort(.password).toOError()
      ])
    )
  }
  
  func test_GivenUserPasswordIsLongerThanMaximum_WhenLogin_ErrorIsThrown() {
    // Given
    let email = "valid_email@gmail.com"
    let password = (1...10).map { _ in "123" }.joined(separator: " ")
        
    // When
    sut.login(email: email, password: password)
    
    // Then
    XCTAssertEqual(
      sut.state.value,
      .failure([
        ValidationError.tooLong(.password).toOError()
      ])
    )
  }
  
  func test_GivenUserDoesntExist_WhenLogin_UserNotFoundErrorIsShown() {
    // Given
    let email = "valid_email@gmail.com"
    let password = "Somevalid1Password"
    
    let expectedError = OError(text: "User not found")
    network.expectedError = expectedError
    
    // When
    sut.login(email: email, password: password)
    
    // Then
    XCTAssertEqual(
      sut.state.value,
      .failure([expectedError])
    )
  }
  
  func test_GivenUserExists_WhenLogin_TokenIsCached() {
    // Given
    let email = "valid_email@gmail.com"
    let password = "Somevalid1Password"
    
    let expectedModel = AccessToken()
    network.expectedObject = expectedModel
    // When
    sut.login(email: email, password: password)
    
    // Then
    XCTAssertNotNil(cache.storage[.accessToken])
  }
}
