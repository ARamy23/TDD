//
//  MockedNetwork.swift
//  TDDTests
//
//  Created by Ahmed Ramy on 03/01/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import Foundation
import Combine
@testable import Entity
@testable import Business
@testable import TDD

/**
 # How to use in testing?
 ```
 network.shouldWait = true
 viewModel.doAsyncTaskThatIamTestingNow()
 network.continueAction?()
 ```
 **/
final class FakeNetworkManager: NetworkProtocol {
  var didRemoveOldRequests: Bool = false
  var calledAPIs = [Endpoint]()
  var expectedObject: Codable?
  var expectedArrayofObjects = [Codable]()
  var expectedError: OError?
  var shouldWait = false
  var continueAction: (() -> Void)?
  var didCallNetwork: Bool {
    calledAPIs.count > 0
  }
  
  var shouldSimulateRealLifeRequest: Bool = false
  
  func removePreviousCall() {
    didRemoveOldRequests = true
  }
  
  func call<T, U>(api: U, model _: T.Type) -> RSResponse<T> where T: Decodable, T: Encodable, U: Endpoint {
    Deferred {
      Future { promise in
        self.calledAPIs.append(api)
        if self.shouldWait {
          self.continueAction = {
            if self.expectedArrayofObjects.isEmpty == false, let object = self.expectedArrayofObjects.removeFirst() as? T {
              promise(.success(object))
            } else if let object = self.expectedObject as? T {
              promise(.success(object))
            } else {
              promise(.failure(self.expectedError ?? .somethingWentWrong))
            }
          }
        } else {
          if self.expectedArrayofObjects.isEmpty == false, let object = self.expectedArrayofObjects.removeFirst() as? T {
            promise(.success(object))
          } else if let object = self.expectedObject as? T {
            promise(.success(object))
          } else {
            promise(.failure(self.expectedError ?? .somethingWentWrong))
          }
        }
      }
    }.eraseToAnyPublisher()
  }
  
  func upload<T, U>(api: U, model _: T.Type) -> RSResponseWithProgress<T> where T: Decodable, T: Encodable, U: Endpoint {
    Deferred {
      Future { promise in
        self.calledAPIs.append(api)
        if self.shouldSimulateRealLifeRequest {
          DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            if self.expectedArrayofObjects.isEmpty == false, let object = self.expectedArrayofObjects.removeFirst() as? T {
              promise(.success(.finished(object)))
            } else if let object = self.expectedObject as? T {
              promise(.success(.finished(object)))
            } else {
              promise(.failure(self.expectedError ?? .somethingWentWrong))
            }
          }
        } else if self.shouldWait {
          self.continueAction = {
            if self.expectedArrayofObjects.isEmpty == false, let object = self.expectedArrayofObjects.removeFirst() as? T {
              promise(.success(.finished(object)))
            } else if let object = self.expectedObject as? T {
              promise(.success(.finished(object)))
            } else {
              promise(.failure(self.expectedError ?? .somethingWentWrong))
            }
          }
        } else {
          if self.expectedArrayofObjects.isEmpty == false, let object = self.expectedArrayofObjects.removeFirst() as? T {
            promise(.success(.finished(object)))
          } else if let object = self.expectedObject as? T {
            promise(.success(.finished(object)))
          } else {
            promise(.failure(self.expectedError ?? .somethingWentWrong))
          }
        }
      }
    }.eraseToAnyPublisher()
  }
  
  init() {}
}
