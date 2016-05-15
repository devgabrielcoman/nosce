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
 Get the clean app name
 Taken from https://github.com/evermeer/EVReflection/blob/master/EVReflection/pod/EVReflection.swift
 
 - returns: A string with the app name
 */
public func getCleanAppName(forObject: NSObject? = nil) -> String {
    var bundle = NSBundle.mainBundle()
    if forObject != nil {
        bundle = NSBundle(forClass: forObject!.dynamicType)
    }
    
    var appName = bundle.infoDictionary?["CFBundleName"] as? String ?? ""
    if appName == "" {
        appName = (bundle.bundleIdentifier!).characters.split(isSeparator: {$0 == "."}).map({ String($0) }).last ?? ""
    }
    let cleanAppName = appName
        .stringByReplacingOccurrencesOfString(" ", withString: "_", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        .stringByReplacingOccurrencesOfString("-", withString: "_", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
    return cleanAppName
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
        
        if let result = unwrap(attr.value) as? Any {
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
    
    // get mirror
    let mirror = Mirror(reflecting: any)
    
    // do unwrapping
    if mirror.displayStyle != .Optional {
        return any
    }
    
    if mirror.children.count == 0 { return NSNull() }
    let (_, some) = mirror.children.first!
    return some
}

/**
 Function that converts an Swift Enum type to it's raw value (either Int or String)
 for storage in JSON data structures
 
 - parameter any: an template T parameter that implements the RawRepresentable protocol
 
 - returns: an AnyObject or NSNull() object
 */
public func enumToNSObject<T: RawRepresentable> (any: T) -> AnyObject {
    if let result = any.rawValue as? AnyObject {
        return result
    }
    return NSNull()
}

func iterateEnum<T: Hashable>(_: T.Type) -> AnyGenerator<T> {
    var i = 0
    return AnyGenerator {
        let next = withUnsafePointer(&i) { UnsafePointer<T>($0).memory }
        i = i + 1
        return next.hashValue == i ? next : nil
    }
}