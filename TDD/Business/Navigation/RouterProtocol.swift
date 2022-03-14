//
//  RouterProtocol.swift
//  TDD
//
//  Created by Ahmed Ramy on 12/03/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import UIKit

public typealias AlertAction = (title: String, style: UIAlertAction.Style, action: () -> Void)

public protocol RouterProtocol: AnyObject {
  func present(_ view: UIViewController)
  func dismiss()
  func pop(animated: Bool)
  func popToRoot()
  func popTo(vc: UIViewController)
  func push(_ view: UIViewController)
  func alertWithAction(
    title: String?,
    message: String?,
    alertStyle: UIAlertController.Style,
    actions: [AlertAction]
  )
}
