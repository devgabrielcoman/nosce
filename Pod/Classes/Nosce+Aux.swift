//
//  Nosce+Aux.swift
//  Pods
//
//  Created by Gabriel Coman on 29/05/2016.
//
//

import UIKit

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