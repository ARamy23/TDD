//
//  MockedCache.swift
//  TDDTests
//
//  Created by Ahmed Ramy on 06/01/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import Foundation
@testable import Entity
@testable import Business
@testable import TDD

final class FakeCache: Storage {
  var storage: [StorageKey: Codable] = [:]
  
  func save<T>(value: T, for key: StorageKey) throws where T : Decodable, T : Encodable {
    storage[key] = value
  }
  
  func fetchValue<T>(for key: StorageKey) -> T? where T : Decodable, T : Encodable {
    storage[key] as? T
  }
  
  func remove<T>(type: T.Type, for key: StorageKey) throws where T : Decodable, T : Encodable {
    storage[key] = nil
  }
}
