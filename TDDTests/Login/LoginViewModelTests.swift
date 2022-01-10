//
//  LoginViewModelTests.swift
//  TDDTests
//
//  Created by Ahmed Ramy on 19/12/2020.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import XCTest
@testable import TDD

class LoginViewModelTests: XCTestCase {
  
  var network: MockedNetwork!
  var cache: MockedCache!
  var sut: LoginViewModel!
  
  override func setUp() {
    super.setUp()
    network = .init()
    cache = .init()
    sut = .init(network: network, cache: cache)
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
    XCTAssertTrue(sut.validationErrors.contains(.empty(.email)))
  }
  
  func test_GivenAnError_WhenLogin_OnErrorIsCalled() {
    // Given
    let email = ""
    let password = ""
    
    // When
    sut.onError = { errors in
      // Then
      XCTAssertEqual(errors.first!.localizedDescription, ValidationError.empty(.email).localizedDescription)
    }
    sut.login(email: email, password: password)
  }
  
  func test_GivenAnEmptyPassword_WhenLogin_ThrowsAnError() {
    // Given
    let email = "valid_email@gmail.com"
    let password = ""
    
    // When
    sut.login(email: email, password: password)
    
    // Then
    XCTAssertTrue(sut.validationErrors.contains(.empty(.password)))
  }
  
  func test_GivenUserPasswordIsShorterThanMinimum_WhenLogin_ErrorIsThrown() {
    // Given
    let email = "valid_email@gmail.com"
    let password = "123"
    
    network.expectedError = NetworkError.userNotFound
    
    // When
    sut.login(email: email, password: password)
    
    // Then
    XCTAssertTrue(
      sut.validationErrors.contains(ValidationError.tooShort(.password))
    )
  }
  
  func test_GivenUserDoesntExist_WhenLogin_UserNotFoundErrorIsShown() {
    // Given
    let email = "valid_email@gmail.com"
    let password = "Somevalid1Password"
    
    network.expectedError = NetworkError.userNotFound
    
    // When
    sut.login(email: email, password: password)
    
    // Then
    XCTAssertTrue(sut.networkErrors.contains(NetworkError.userNotFound))
  }
  
  func test_GivenUserExists_WhenLogin_TokenIsCached() {
    // Given
    let email = "valid_email@gmail.com"
    let password = "Somevalid1Password"
    
    let expectedModel = AccessToken()
    network.expectedModel = expectedModel
    // When
    sut.login(email: email, password: password)
    
    // Then
    XCTAssertNotNil(cache.storage[.accessToken])
  }
}
