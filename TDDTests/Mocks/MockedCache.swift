//
//  MockedCache.swift
//  TDDTests
//
//  Created by Ahmed Ramy on 06/01/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import Foundation
@testable import TDD

final class MockedCache: CacheProtocol {
  
  var storage: [StorageKey: Codable] = [:]
  
  func fetch<T: Codable>(_: T.Type, for key: StorageKey) -> T? {
    storage[key] as? T
  }
  
  func save<T: Codable>(_ value: T, for key: StorageKey) {
    storage[key] = value
  }
  
  func remove(for key: StorageKey) {
    storage[key] = nil
  }
}
