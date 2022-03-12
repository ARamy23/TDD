//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 12/03/2022.
//

import Foundation

public enum ValidationError: Error {
    case empty(BusinessConfigurations.Validation.Field)
    case tooShort(BusinessConfigurations.Validation.Field)
    case tooLong(BusinessConfigurations.Validation.Field)
}

extension ValidationError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
            case let .empty(field):
                return "\(field.title) can't be empty"
            case let .tooShort(field):
                return "\(field.title) can't be shorter than \(field.minMax.min) characters."
            case let .tooLong(field):
                return "\(field.title) can't be longer than \(field.minMax.max) characters."
        }
    }
}

extension ValidationError: Equatable { }
