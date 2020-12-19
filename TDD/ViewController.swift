//
//  ViewController.swift
//  TDD
//
//  Created by Ahmed Ramy on 10/24/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet private weak var emailTextField: UITextField!
  @IBOutlet private weak var passwordTextField: UITextField!
  
  private lazy var viewModel = LoginViewModel()
  
  @IBAction func didTapLogin() {
    viewModel.login(
      email: emailTextField.text ?? "",
      password: passwordTextField.text ?? ""
    )
  }
}

