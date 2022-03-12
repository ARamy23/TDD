//
//  Int+Extensions.swift
//  
//
//  Created by Ahmed Ramy on 02/03/2022.
//

import Foundation

public extension Comparable {
  func clamped(to limits: ClosedRange<Self>) -> Self {
    return min(max(self, limits.lowerBound), limits.upperBound)
  }
}

#if swift(<5.1)
public extension Strideable where Stride: SignedInteger {
  func clamped(to limits: CountableClosedRange<Self>) -> Self {
    return min(max(self, limits.lowerBound), limits.upperBound)
  }
}
#endif
