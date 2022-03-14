//
//  FakeRouter.swift
//  TDDTests
//
//  Created by Ahmed Ramy on 12/03/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import UIKit
@testable import TDD

enum RoutingAction: Equatable {
  case present(_ vc: UIViewController.Type)
  case push(_ vc: UIViewController.Type)
  case dismiss
  case pop
  case popToRoot
  case popToVC
  case popTo(_ vc: UIViewController.Type)
  case alertWithAction((title: String, message: String))
  
  static public func ==(lhs: RoutingAction, rhs: RoutingAction) -> Bool {
    switch (lhs, rhs) {
      case let (.popTo(a), .popTo(b)): return a == b
      case let (.present(a), .present(b)): return a == b
      case let (.push(a), .push(b)): return a == b
      case let (.alertWithAction(a), .alertWithAction(b)):
        return a.title == b.title && a.message == b.message
      case (.dismiss, .dismiss),
        (.pop, .pop),
        (.popToRoot, .popToRoot),
        (.popToVC, .popToVC):
        return true
      default:
        return false
    }
  }
}

final class FakeRouter: RouterProtocol {
  var actions: [RoutingAction] = []
  var alertActions: [AlertAction] = []
  
  func popToRoot() {
    actions.append(.popToRoot)
  }
  
  func popTo(vc: UIViewController) {
    actions.append(.popToVC)
  }
  
  func push(_ view: UIViewController) {
    actions.append(.push(type(of: view)))
  }
  
  func present(_ view: UIViewController) {
    actions.append(.present(type(of: view)))
  }
  
  func dismiss() {
    self.actions.append(.dismiss)
  }
  
  func alertWithAction(
    title: String?,
    message: String?,
    alertStyle: UIAlertController.Style,
    actions: [AlertAction]
  ) {
    self.actions.append(.alertWithAction((title ?? "", message ?? "")))
    self.alertActions.append(contentsOf: actions)
  }
  
  func pop(animated: Bool) {
    self.actions.append(.pop)
  }
}
