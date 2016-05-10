//
//  Nosce+Deserialize.swift
//  Pods
//
//  Created by Gabriel Coman on 24/04/2016.
//  You can contact me at dev.gabriel.coman@gmail.com
//
//  This module contains functions meant to transform a valid JSON string into
//  a predefined model
//  The main function is deserialize
//

import UIKit

/**
 Deserialize from a JSON string
 
 - parameter model:      the base model to try to serialize
 - parameter jsonString: valid json source string
 
 - returns: a deserialized model
 */
public func deserialize<A>(model: A, jsonString: String) -> AnyObject {
    if let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
        return deserialize(model, jsonData: jsonData)
    }
    return 0
}

/**
 Deserialize from a JSON NSData object
 
 - parameter model:    the base model to try to serialize
 - parameter jsonData: a valid json NSData source
 
 - returns: a deserialized model
 */
public func deserialize<A>(model: A, jsonData: NSData) -> AnyObject {
    do {
        let dict = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
        return deserialize(model, json: dict)
    } catch let error as NSError {
        print(error)
    }
    return 0
}

/**
 Deserialize from a generic dictionary or array
 
 - parameter model: the base model to try to serialize
 - parameter json:  a generic json dictionary or array of dictionaries
 
 - returns: a deserialized model
 */
public func deserialize<A, B>(model:A, json: B) -> AnyObject {
    
    let modelType = getDisplayType(model)
    let modelClass = getClassNameAsString(model)
    let appName = getCleanAppName()
    
    //
    // Handled Case #1:
    //  - "model" is a NSObject
    //  - "json" is a NSDictionary
    if let modelClassName = NSClassFromString("\(appName).\(modelClass)") as? NSObject.Type,
        let json = json as? NSDictionary where modelType == .Class
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
    else if let array = json as? NSArray where modelType == .Array {
        
        let elementClass = getArrayContentType(modelClass)
        var newArray = [].mutableCopy()
        
        // the array is of other types of classes
        if let elementClassName = NSClassFromString("\(appName).\(elementClass)") as? NSObject.Type {
            
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
    else if (modelType == .Bool || modelType == .Int || modelType == .Float || modelType == .Double || modelType == .String || modelType == .NSNull || modelType == .NSValue) {
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

/**
 Get the clean app name
 Taken from https://github.com/evermeer/EVReflection/blob/master/EVReflection/pod/EVReflection.swift
 
 - returns: A string with the app name
 */
private func getCleanAppName() -> String {
    var bundle = NSBundle.mainBundle()
    var appName = bundle.infoDictionary?["CFBundleName"] as? String ?? ""
    if appName == "" {
        appName = (bundle.bundleIdentifier!).characters.split(isSeparator: {$0 == "."}).map({ String($0) }).last ?? ""
    }
    let cleanAppName = appName
        .stringByReplacingOccurrencesOfString(" ", withString: "_", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        .stringByReplacingOccurrencesOfString("-", withString: "_", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
    return cleanAppName
}
