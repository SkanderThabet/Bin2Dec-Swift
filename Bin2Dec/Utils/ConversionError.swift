//
//  ConversionError.swift
//  Bin2Dec
//
//  Created by Skander Thabet on 19/01/2025.
//

import Foundation

public enum ConversionError: LocalizedError {
    case invalidCharacters
    case exceededMaxLength
    
    public var errorDescription: String? {
        switch self {
        case .invalidCharacters:
            return "Only 0 and 1 allowed"
        case .exceededMaxLength:
            return "Maximum 8 digits allowed"
        }
    }
}
