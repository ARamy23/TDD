//
//  NetworkProtocol.swift
//  TDD
//
//  Created by Ahmed Ramy on 03/01/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import Foundation

protocol NetworkProtocol {
    func call<Input: Endpoint, Output: Codable>(
        api: Input,
        expected: Output.Type,
        onComplete: (Result<Output, NetworkError>) -> ()
    )
}

public final class URLSessionNetwork: NetworkProtocol {
  func call<Input, Output>(api: Input, expected: Output.Type, onComplete: (Result<Output, NetworkError>) -> ()) where Input : Endpoint, Output : Decodable, Output : Encodable {
    
  }
}
