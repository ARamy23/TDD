//
//  StorageKeys.swift
//  TDD
//
//  Created by Ahmed Ramy on 12/03/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import Business

extension StorageKey {
  static let accessToken: StorageKey = .init(key: "accessToken", suitableStorage: .encrypted)
}
