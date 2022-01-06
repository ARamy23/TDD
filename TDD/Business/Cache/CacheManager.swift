//
//  CacheManager.swift
//  TDD
//
//  Created by Ahmed Ramy on 06/01/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import Foundation

final class CacheManager: CacheProtocol {
  private let encryptedStorage: EncryptedStorage = .init()
  
  func fetch<T: Codable>(_ type: T.Type, for key: StorageKey) -> T? {
    selectSuitableStorage(from: key).fetchValue(type, for: key)
  }
  
  func save<T: Codable>(_ value: T, for key: StorageKey) {
    selectSuitableStorage(from: key).save(value: value, for: key)
  }
  
  func remove(for key: StorageKey) {
    selectSuitableStorage(from: key).remove(for: key)
  }
  
  private func selectSuitableStorage(from key: StorageKey) -> StorageProtocol {
    switch key.suitableStorage {
    case .encrypted:
      return encryptedStorage
    }
  }
}
