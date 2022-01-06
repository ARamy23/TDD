//
//  CacheProtocol.swift
//  TDD
//
//  Created by Ahmed Ramy on 05/01/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import Foundation

protocol CacheProtocol {
  func fetch<T: Codable>(_: T.Type, for key: StorageKey) -> T?
  func save<T: Codable>(_ value: T, for key: StorageKey)
  func remove(for key: StorageKey)
}

public enum StorageKey: CaseIterable {
    case accessToken
    
    var identifier: String {
        switch self {
        case .accessToken:
            return "accessToken"
        }
    }

    var suitableStorage: SupportedStorage {
        switch self {
        case .accessToken:
            return .encrypted
        }
    }
}

extension StorageKey {
  enum SupportedStorage {
    case encrypted
  }
}

