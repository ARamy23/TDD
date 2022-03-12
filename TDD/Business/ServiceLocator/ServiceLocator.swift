//
//  ServiceLocator.swift
//  TDD
//
//  Created by Ahmed Ramy on 12/03/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import Foundation

public final class ServiceLocator {
  static var main: ServiceLocator = .init()
  
  let network: NetworkProtocol
  let cache: CacheProtocol
  
  init(
    network: NetworkProtocol = URLSessionNetwork(),
    cache: CacheProtocol = CacheManager()
  ) {
    self.network = network
    self.cache = cache
  }
}
