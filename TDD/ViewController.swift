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
  @IBOutlet private weak var loginButtonActivityView: UIActivityIndicatorView!
  @IBOutlet private weak var statusLabel: UILabel!
  
  private lazy var viewModel = LoginViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // TODO: - Bind State
  }
  
  @IBAction func didTapLogin() {
    viewModel.login(
      email: emailTextField.text ?? "",
      password: passwordTextField.text ?? ""
    )
  }
}
