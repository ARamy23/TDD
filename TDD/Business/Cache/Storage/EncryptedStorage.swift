//
//  EncryptedStorage.swift
//  TDD
//
//  Created by Ahmed Ramy on 06/01/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import Foundation
import KeychainSwift

public final class EncryptedStorage {
  private let keychain = KeychainSwift()
}

extension EncryptedStorage: StorageProtocol {
  public func fetchValue<T: Codable>(_ type: T.Type, for key: StorageKey) -> T? {
    keychain.getData(key.identifier)?.decode(type)
  }
  
  public func save<T: Codable>(value: T, for key: StorageKey) {
    guard let data = value.encode() else { return }
    keychain.set(data, forKey: key.identifier)
  }
  
  public func remove(for key: StorageKey) {
    keychain.delete(key.identifier)
  }
}

extension Encodable {
    func encode() -> Data? {
      do {
        return try JSONEncoder().encode(self)
      } catch {
      #if DEBUG
        debugPrint("[Encoding Error] Failed to Encode \(self)\nError: \(error)")
      #endif
        return nil
      }
    }
}

extension Data {
    func decode<T: Decodable>(_ object: T.Type) -> T? {
        do {
            return (try JSONDecoder().decode(T.self, from: self))
        } catch {
          #if DEBUG
            debugPrint("[Parse Error] Failed to Parse Object with this type: \(object)\nError: \(error)")
          #endif
            return nil
        }
    }
}
