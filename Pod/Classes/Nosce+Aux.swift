//
//  Nosce+Aux.swift
//  Pods
//
//  Created by Gabriel Coman on 23/04/2016.
//  You can contact me at dev.gabriel.coman@gmail.com
//
//  A module containing aux functions
//

import UIKit

/**
 Get a value's class name as a String, based on dynamicType
 
 - parameter any: a value of Any type
 
 - returns: a class name as string
 */
public func getClassNameAsString(any: Any) -> String {
    return String(any.dynamicType).componentsSeparatedByString("__").last!
}

/**
 Function that prints out the detected type of a value and compares it to
 the printed class name (as given by Swift's reflection mechanism)
 
 - parameter v: value conforming to Any
 */
public func printType(v:Any) {
    
    var t = ""
    if isBoolType(v) { t = "Bool type" }
    else if isIntType(v) { t = "Int type" }
    else if isFloatType(v) { t = "Float type" }
    else if isDoubleType(v) { t = "Double type" }
    else if isStringType(v) { t = "String type" }
    else if isNSNullType(v) { t = "NSNull type" }
    else if isNSValueType(v) { t = "NSValue type" }
    else if isArrayType(v) { t = "Array type" }
    else if isDictionaryType(v) { t = "Dictionary type" }
    else if isSetType(v) { t = "Set type" }
    else { t = "\(getClassNameAsString(v)) type" }
    let expected = getClassNameAsString(v)
    print("Expected \(expected) and got \(t)")
}