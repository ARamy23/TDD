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
  
  private lazy var viewModel = LoginViewModel(network: URLSessionNetwork())
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.onError = { [weak self] errors in
      self?.showErrorsAlert(errors: errors)
    }
  }
  
  @IBAction func didTapLogin() {
    viewModel.login(
      email: emailTextField.text ?? "",
      password: passwordTextField.text ?? ""
    )
  }
}

private extension ViewController {
  func showErrorsAlert(errors: [Error]) {
    let alert = UIAlertController(
      title: "Oops, something went wrong.",
      message: errors.map { $0.localizedDescription }.joined(separator: "\n"),
      preferredStyle: .alert
    )
    
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    
    self.present(alert, animated: true, completion: nil)
  }
}
