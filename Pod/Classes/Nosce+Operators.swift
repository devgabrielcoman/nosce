//
//  Nosce+Operators.swift
//  Pods
//
//  Created by Gabriel Coman on 28/05/2016.
//
//

import UIKit

infix operator => { associativity right precedence 100 }

// model to dictionary

public func => <A, B, C> (left: [A], right: (B) -> C ) -> NSArray {
    let array = NSMutableArray()
    for item in left {
        if let item = item as? B, let result = right(item) as? AnyObject {
            array.addObject(result)
        }
    }
    return array
}

// dictionary to model

public func => <B, C> (left: AnyObject?, right: (B) -> C? ) -> [C] {
    
    if let object = left as? [AnyObject] {
        var array: [C] = []
        
        for item in object {
            if let item = item as? B, let result = right(item) {
                array.append(result)
            }
        }
        
        return array
    }
    return []
}

// assignment

infix operator <- { associativity right precedence 100 }

public func <- <A, B> (inout left: A, right: B?) {
    if let right = right as? A {
        left = right
    }
}
