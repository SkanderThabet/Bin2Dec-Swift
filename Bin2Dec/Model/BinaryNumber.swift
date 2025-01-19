//
//  BinaryNumber.swift
//  Bin2Dec
//
//  Created by Skander Thabet on 19/01/2025.
//

import UIKit

struct BinaryNumber {
    static let maxLength = 8
    let value:String
    
    var isValid : Bool {
        value.allSatisfy { $0 == "0" || $0 == "1" }
    }
    
    var isExceedMaxLength : Bool {
        value.count > BinaryNumber.maxLength
    }
    
    var decimalValue: Int? {
        guard isValid, !isExceedMaxLength, !value.isEmpty else {return nil}
        return Int(value,radix: 2)
    }
}
