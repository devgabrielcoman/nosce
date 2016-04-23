//
//  Nosce+Types.swift
//  Pods
//
//  Created by Gabriel Coman on 23/04/2016.
//  You can contact me at dev.gabriel.coman@gmail.com
//
//  This module contains aux functions that are used to detect what type an
//  object is and also try to place it into a generic bucket (e.g. basic types,
//  arrays, custom objects, etc)
//

import UIKit

/**
 Enum with all types of condensed into usable ones
 
 - NonHandledType:   All types like Int, Float, String, NSNull, NSValue, etc
 - ArrayType:        All types like Array, NSArray, NSMutableArray
 - DictionaryType:   All types like NSDictionary, Dictionary, NSMutableDictionary
 - SetType:          All types like NSSet
 - CustomObjectType: All custom class types
 */
public enum DetectedType {
    case NonHandledType
    case ArrayType
    case DictionaryType
    case SetType
    case CustomObjectType
}

/**
 *  Generic nested type protocol
 */
protocol NosceNestedType {}
extension Array: NosceNestedType {}
extension Set: NosceNestedType {}
extension Dictionary: NosceNestedType {}
extension NSDictionary: NosceNestedType {}
extension NSSet: NosceNestedType {}

/**
 *  Generic array type protocol
 */
protocol NosceArrayType {}
extension Array: NosceArrayType {}
extension NSArray: NosceArrayType {}

/**
 *  Generic dictionary type protocol
 */
protocol NosceDictionaryType {}
extension Dictionary: NosceDictionaryType {}
extension NSDictionary: NosceDictionaryType {}

/**
 *  Generic set type protocol
 */
protocol NosceSetType {}
extension NSSet: NosceSetType {}

/**
 Checks whether a given value is a Bool
 
 - parameter any: value conforming to Any
 
 - returns: true or false
 */
public func isBoolType(any: Any) -> Bool {
    return (
        any is Bool || any is BooleanType
    )
}

/**
 Checks whether a given value is a Int
 
 - parameter any: value conforming to Any
 
 - returns: true or false
 */
public func isIntType(any: Any) -> Bool {
    return (
        any is Int || any is UInt ||
            any is Int8 || any is UInt8 ||
            any is Int16 || any is UInt16 ||
            any is Int32 || any is UInt32 ||
            any is Int64 || any is UInt64
    )
}

/**
 Checks whether a given value is a Float
 
 - parameter any: value conforming to Any
 
 - returns: true or false
 */
public func isFloatType(any: Any) -> Bool {
    return (
        any is Float ||
            any is Float32 ||
            any is Float64 ||
            any is Float80
    )
}

/**
 Checks whether a given value is a Double
 
 - parameter any: value conforming to Any
 
 - returns: true or false
 */
public func isDoubleType(any: Any) -> Bool {
    return (
        any is Double ||
            any is double_t ||
            any is CDouble
    )
}

/**
 Checks whether a given value is a String
 
 - parameter any: value conforming to Any
 
 - returns: true or false
 */
public func isStringType(any: Any) -> Bool {
    return (
        any is String
    )
}

/**
 Checks whether a given value is an Array
 
 - parameter any: value conforming to Any
 
 - returns: true or false
 */
public func isArrayType(any: Any) -> Bool {
    return (
        any is NosceArrayType
    )
}

/**
 Checks whether a given value is a Dictionary
 
 - parameter any: value conforming to Any
 
 - returns: true or false
 */
public func isDictionaryType(any: Any) -> Bool {
    return (
        any is NosceDictionaryType
    )
}

/**
 Checks whether a given value is a Set / NSSet
 
 - parameter any: value conforming to Any
 
 - returns: true or false
 */
public func isSetType(any: Any) -> Bool {
    return (
        any is NosceSetType
    )
}

/**
 Checks whether a given value is a NSNull
 
 - parameter any: value conforming to Any
 
 - returns: true or false
 */
public func isNSNullType(any: Any) -> Bool {
    if let any = any as? NSObject {
        return (
            any.isKindOfClass(NSNull.classForCoder())
        )
    }
    return false
}

/**
 Checks whether a given value is a NSValue
 
 - parameter any: value conforming to Any
 
 - returns: true or false
 */
public func isNSValueType(any: Any) -> Bool {
    if let any = any as? NSObject {
        return (
            !any.isKindOfClass(NSNull.classForCoder()) &&
                any.isKindOfClass(NSValue.classForCoder())
        )
    }
    return false
}

/**
 Function that gets a value of a certain type, finds out the type and condenses
 it into a way that's easy to handle for the parser
 
 - parameter any: a value of Any type
 
 - returns: a Detected Type enum
 */
public func getDetectedType(any: Any) -> DetectedType {
    
    if isBoolType(any) || isIntType(any) || isFloatType(any) || isDoubleType(any) ||
        isStringType(any) || isNSNullType(any) || isNSValueType(any) {
        return .NonHandledType
    }
    else if isArrayType(any) {
        return .ArrayType
    }
    else if isDictionaryType(any) {
        return .DictionaryType
    }
    else if isSetType(any) {
        return .SetType
    }
    
    return .CustomObjectType
}
