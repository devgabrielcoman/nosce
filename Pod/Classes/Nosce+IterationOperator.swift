//
//  Nosce+Operators.swift
//  Pods
//
//  Created by Gabriel Coman on 28/05/2016.
//
//  Module that defines an "iteration" operator over arrays

import UIKit

//infix operator => { associativity right precedence 100 }
//
///**
// Used when iterating when transforming from model to dictionaray
// 
// - parameter left:  an array of type A
// - parameter right: an iteration function of type (param: B) -> C
// 
// - returns: a NSArray of values
// */
//public func => <A, B, C> (left: [A], right: (B) -> C ) -> NSArray {
//    let array = NSMutableArray()
//    for item in left {
//        if let item = item as? B, let result = right(item) as? AnyObject {
//            array.addObject(result)
//        }
//    }
//    return array
//}
//
///**
// Used when iterating when transforming from dictionary to model
// 
// - parameter left:  an "AnyObject" optional type, later to be interpreted as an array
// - parameter right: an iteration function of type (param: B) -> C?
// 
// - returns: an array of type C
// */
//public func => <A, B> (left: AnyObject?, right: (A) -> B? ) -> [B] {
//    
//    if let object = left as? [AnyObject] {
//        var array: [B] = []
//        
//        for item in object {
//            if let item = item as? A, let result = right(item) {
//                array.append(result)
//            }
//        }
//        
//        return array
//    }
//    return []
//}
