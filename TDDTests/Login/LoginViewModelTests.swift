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
}
