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

  var sut: LoginViewModel!
  
  override func setUp() {
    super.setUp()
    sut = LoginViewModel()
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
  }
  
  func test_GivenEmptyEmail_WhenLogin_ShowError() {
    // Given
    let email = ""
    let password = ""
    
    // When
    sut.login(email: email, password: password)
    
    // Then
    XCTAssertTrue(sut.validationErrors.contains(ValidationError.emailIsEmpty)) // <- ADDED
  }
  
  func test_GivenAnError_WhenLogin_OnErrorIsCalled() {
    // Given
    let email = ""
    let password = ""
    
    // When
    sut.onError = { errors in
      // Then
      XCTAssertEqual(errors.first!.localizedDescription, ValidationError.emailIsEmpty.localizedDescription)
    }
    sut.login(email: email, password: password)
  }
}
