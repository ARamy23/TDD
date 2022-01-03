//
//  MockedNetwork.swift
//  TDDTests
//
//  Created by Ahmed Ramy on 03/01/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import Foundation
@testable import TDD

final class MockedNetwork: NetworkProtocol {
    var expectedError: NetworkError?
    var expectedModel: Codable?
    
    func call<Input: Endpoint, Output: Codable>(api: Input, expected: Output.Type, onComplete: (Result<Output, NetworkError>) -> ()) {
        if let expectedModel = expectedModel as? Output {
            onComplete(.success(expectedModel))
        } else {
            onComplete(.failure(expectedError!))
        }
    }
}
