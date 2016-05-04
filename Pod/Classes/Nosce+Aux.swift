//
//  Nosce+Aux.swift
//  Pods
//
//  Created by Gabriel Coman on 23/04/2016.
//  You can contact me at dev.gabriel.coman@gmail.com
//
//  A module containing Aux functions
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
 Function that forcibly unwraps an array of optionals
 
 - parameter any: an "Any" object that's going to be handled like an array
 
 - returns: an array of "Any" objects
 */
public func unwrapArray(any: Any) -> [Any] {
    let mi = Mirror(reflecting: any)
    var array:[Any] = []
    for (_, attr) in mi.children.enumerate() {
        
        if let result = unwrap(attr.value) as? AnyObject {
            array.append(result)
        }
    }
    
    return array
}

/**
 Force unwrap an optional
 Based on solution provided by
 http://stackoverflow.com/users/4045472/bubuxu
 to this question
 http://stackoverflow.com/questions/27989094/how-to-unwrap-an-optional-value-from-any-type
 
 - parameter any: force unwrap an optional
 
 - returns: an "Any" value or NSNull()
 */
public func unwrap(any:Any) -> Any {
    
    if let mi = Mirror(reflecting: any) as? Mirror {
        if mi.displayStyle != .Optional {
            return any
        }
        
        if mi.children.count == 0 { return NSNull() }
        let (_, some) = mi.children.first!
        return some
    }
    return NSNull()
}

public func displayStyle(any:Any) -> Any {
    if let mi = Mirror(reflecting: any) as? Mirror {
        return mi.displayStyle
    }
    return NSNull()
}