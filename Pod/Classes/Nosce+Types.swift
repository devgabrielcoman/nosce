//
//  Nosce+Types2.swift
//  Pods
//
//  Created by Gabriel Coman on 04/05/2016.
//
//

import UIKit

/**
 An enum holding all major display types
 
 - Unknown:    Worst case scenario - don't know what type is
 - Bool:       A bool type
 - Int:        An Int type
 - Float:      A Float type
 - Double:     A Double type
 - String:     A String / NSString type
 - NSNull:     A NSNull type
 - NSValue:    A NSValue type
 - Struct:     A Struct type
 - Class:      A generic Class type
 - Enum:       An Enum Type
 - Tuple:      A Tuple Type
 - Array:      An Array Type
 - Dictionary: A Dictionary Type
 - Set:        A Set Type
 - Optional:   An Optional Type
 */
public enum DisplayType: Int {
    case Unknown = 0
    case Bool
    case Int
    case Float
    case Double
    case String
    case NSNull
    case NSValue
    case Array
    case Set
    case Dictionary
    case Class
    case Struct
    case Enum
    case Tuple
    case Optional
}

/**
 get the Display type
 
 - parameter any: any type of value
 
 - returns: a value from the enum defined above
 */
public func getDisplayType<T>(any: T) -> DisplayType {
    
    // get the mirror
    let mirror = Mirror(reflecting: any)
    
    // if I can get the mirror's display type safely
    // then do something with that
    if let style: Mirror.DisplayStyle = mirror.displayStyle {
        switch style {
        case .Struct: return .Struct
        case .Enum: return .Enum
        case .Tuple: return .Tuple
        case .Collection: return .Array
        case .Dictionary: return .Dictionary
        case .Set: return .Set
        case .Optional: return .Optional
        case .Class:
            if isNSNullType(any) { return .NSNull }
            if isNSValueType(any) { return .NSValue }
            return .Class
        }
    }
        // else it's probably a base type (int, bool, etc) and have to
        // use my custom functions to do it
    else {
        if isBoolType(any) { return .Bool }
        if isIntType(any) { return .Int }
        if isDoubleType(any) { return .Double }
        if isFloatType(any) { return .Float }
        if isStringType(any) { return .String }
        if isNSNullType(any) { return .NSNull }
        if isNSValueType(any) { return .NSValue }
    }
    
    return .Unknown
}

/**
 Determine whether a type is Bool or not
 
 - parameter any: any type of value
 
 - returns: true or false
 */
public func isBoolType<T>(any: T) -> Bool {
    return any is Bool || any is BooleanType
}

/**
 Determine whether a type is Int or not
 
 - parameter any: any type of value
 
 - returns: true or false
 */
public func isIntType<T>(any: T) -> Bool {
    return any is Int || any is UInt || any is Int8 || any is UInt8 || any is Int16 || any is UInt16 || any is Int32 || any is UInt32 || any is Int64 || any is UInt64
}

/**
 Determine whether a type is Float or not
 
 - parameter any: any type of value
 
 - returns: true or false
 */
public func isFloatType<T>(any: T) -> Bool {
    return any is Float || any is Float32 || any is Float64
}

/**
 Determine whether a type is Double or not
 
 - parameter any: any type of value
 
 - returns: true or false
 */
public func isDoubleType<T>(any: T) -> Bool {
    return any is Double || any is double_t || any is CDouble
}

/**
 Determine whether a type is String or not
 
 - parameter any: any type of value
 
 - returns: true or false
 */
public func isStringType<T>(any: T) -> Bool {
    return any is String
}

/**
 Determine whether a type is NSNull or not
 
 - parameter any: any type of value
 
 - returns: true or false
 */
public func isNSNullType<T>(any: T) -> Bool {
    if let any = any as? NSObject {
        return any.isKindOfClass(NSNull.classForCoder())
    }
    return false
}

/**
 Determine whether a type is a NSValue or not
 
 - parameter any: any type of value
 
 - returns: true or false
 */
public func isNSValueType<T>(any: T) -> Bool {
    if let any = any as? NSObject {
        return !any.isKindOfClass(NSNull.classForCoder()) && any.isKindOfClass(NSValue.classForCoder())
    }
    return false
}
