//
//  Nosce+Deserialize.swift
//  Pods
//
//  Created by Gabriel Coman on 24/04/2016.
//  You can contact me at dev.gabriel.coman@gmail.com
//
//  This module contains functions meant to transform a valid JSON string into
//  a predefined model
//

import UIKit

public func deserialize<A, B>(model:A, json: B) -> AnyObject {
    
    let modelType = getDetectedType(model)
    let modelClass = getClassNameAsString(model)
    
    //
    // Handled Case #1:
    //  - "model" is a NSObject
    //  - "json" is a NSDictionary
    if let modelClassName = NSClassFromString("Nosce_Example.\(modelClass)") as? NSObject.Type,
        let json = json as? NSDictionary where modelType == .CustomObjectType
    {
        // init a new instance
        let instance = modelClassName.init()
        let mirror = Mirror(reflecting: instance)
        
        for (_, attribute) in mirror.children.enumerate() {
            let label = attribute.label! as String!
            let value = attribute.value
            let dictValue = unwrap(json.objectForKey(label))
            let result = deserialize(value, json: dictValue)
            instance.setValue(result, forKey: label)
        }
        
        // final return
        return instance
    }
    //
    // Handled Case #2:
    //  - "model" is an Array Type
    //  - "json" is a NSArray
    else if let array = json as? NSArray where modelType == .ArrayType {
        
        let elementClass = getArrayContentType(modelClass)
        var newArray = [].mutableCopy()
        
        // the array is of other types of classes
        if let elementClassName = NSClassFromString("Nosce_Example.\(elementClass)") as? NSObject.Type {
            
            for var item in array {
                let instance = elementClassName.init()
                if let item = item as? NSDictionary {
                    let result = deserialize(instance, json: item)
                    newArray.addObject(result)
                }
            }
        }
        // the array must of of Int, Float, etc, types
        else {
            // @todo: again be careful here
            newArray = array
        }
        
        // return
        return newArray
    }
    // 
    // Handled Case #3:
    //  - "model" is an Int, Float, etc, Type
    //  - "json" doesn't really matter
    else if modelType == .NonHandledType {
        // @todo: this might cause problems
        return json as! AnyObject
    }
    
    return 0
}

/**
 Private function that finds out from string like "Array<NSObject>" what the
 object in angular brackets is
 
 - parameter type: a String that looks like "Array<NSObject>
 
 - returns: NSObject as String
 */
private func getArrayContentType(type: String) -> String {
    if let r1 = type.rangeOfString("<"), let r2 = type.rangeOfString(">") where r1.endIndex < r2.startIndex {
        return type.substringWithRange(Range(start: r1.endIndex, end: r2.startIndex))
    }
    return type
}
