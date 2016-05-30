//
//  Nosce+AssignmentOperator.swift
//  Pods
//
//  Created by Gabriel Coman on 30/05/2016.
//
//  Module that defines an assignment operator

import UIKit

// assignment between two identical types

infix operator <- { associativity right precedence 100 }

/**
 Operator function that defines the assignment operation
 
 - parameter left:  can be any type
 - parameter right: can be any type
 */
public func <- <A, B> (inout left: A, right: B?) {
    if let right = right as? A {
        left = right
    }
}