//
//  StorageProtocol.swift
//  TDD
//
//  Created by Ahmed Ramy on 06/01/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import Foundation

public protocol ReadableStorageProtocol {
  func fetchValue<T: Codable>(_ type: T.Type, for key: StorageKey) -> T?
}

public protocol WritableStorageProtocol {
  func save<T: Codable>(value: T, for key: StorageKey)
  func remove(for key: StorageKey)
}

public typealias StorageProtocol = ReadableStorageProtocol & WritableStorageProtocol
