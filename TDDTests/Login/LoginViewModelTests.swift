//
//  LoginViewModelTests.swift
//  TDDTests
//
//  Created by Ahmed Ramy on 19/12/2020.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import XCTest
// #1
@testable import TDD

class LoginViewModelTests: XCTestCase {

  // #2
  var sut: LoginViewModel!
  
  override func setUp() {
    super.setUp()
    // #3
    sut = LoginViewModel()
  }
  
  override func tearDown() {
    super.tearDown()
    // #4
    sut = nil
  }
}
