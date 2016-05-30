//
//  Nosce+Aux.swift
//  Pods
//
//  Created by Gabriel Coman on 29/05/2016.
//
//  Module that defines an unwrap function for optional

import UIKit

/**
 Unwrap function for optionals
 
 - parameter any: any type in swift
 
 - returns: Either the value or the unwrapped optional or NSNull()
 */
public func unwrap (any: Any) -> AnyObject {
    
    // get mirror
    let mirror = Mirror(reflecting: any)
    
    // do unwrapping
    if mirror.displayStyle != .Optional {
        return any as! AnyObject
    }
    
    if mirror.children.count == 0 { return NSNull() }
    let (_, some) = mirror.children.first!
    return some as! AnyObject
}