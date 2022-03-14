//
//  Router.swift
//  TDD
//
//  Created by Ahmed Ramy on 12/03/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import Foundation
import UIKit

public final class Router: RouterProtocol {
  private weak var presentedView: UIViewController!
  
  init(_ view: UIViewController) {
    presentedView = view
  }
  
  public func present(_ view: UIViewController) {
    presentedView?.present(view, animated: true, completion: nil)
  }
  
  public func dismiss() {
    presentedView?.dismiss(animated: true, completion: nil)
  }
  
  public func pop(animated: Bool) {
    _ = presentedView?.navigationController?.popViewController(animated: animated)
  }
  
  public func popToRoot() {
    _ = presentedView?.navigationController?.popToRootViewController(animated: true)
  }
  
  public func popTo(vc: UIViewController) {
    _ = presentedView?.navigationController?.popToViewController(vc, animated: true)
  }
  
  public func push(_ view: UIViewController) {
    presentedView?
      .navigationController?
      .pushViewController(view, animated: true)
  }

  public func alertWithAction(
    title: String?,
    message: String?,
    alertStyle: UIAlertController.Style,
    actions: [AlertAction]
  ) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
    actions.map { action in
      UIAlertAction(title: action.title, style: action.style, handler: { (_) in
        action.action()
      })
    }.forEach {
      alert.addAction($0)
    }
    
    presentedView?.present(alert, animated: true)
  }
}
