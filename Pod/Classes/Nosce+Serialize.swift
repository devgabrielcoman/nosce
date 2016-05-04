//
//  Nosce3.swift
//  Pods
//
//  Created by Gabriel Coman on 23/04/2016.
//  You can contact me at dev.gabriel.coman@gmail.com
//
//  This module contains some functionat that make it easy to transform
//  custom objects into dictionaries and into Json
//  
//  with the "serialize<T>(any: T, format: SerializationFormat)" function you 
//  can take any model object and have it's dictionary representation generated
//
//  with the "jsonStringRepresentation<T>(any:T)" function you can take that
//  dictionary representation and transform it into a valid Json, if the
//  dictionary is valid as well
//

import UIKit

/**
 Describes the serialization options available
 
 - toDictionary:  the main function returns a Dictionary
 - toCompactJSON: the main function returns a compact JSON string
 - toPreetyJSON:  the main function returns a preety JSON string
 - toNSData:      the main function returns a NSData object
 */
public enum SerializationFormat {
    case toDictionary
    case toCompactJSON
    case toPreetyJSON
    case toNSData
}

/**
 Main module function that interfaces with the user
 
 - parameter any:    the data / models that need to be serialized
 - parameter format: the format
 
 - returns: a dictionary or string or whatnot
 */
public func serialize<T>(any: T, format: SerializationFormat) -> Any {
    switch format {
    case .toDictionary: return jsonDictionaryRepresentation(any)
    case .toCompactJSON: return jsonStringCompactRepresentation(any)
    case .toPreetyJSON: return jsonStringPrettyRepresentation(any)
    case .toNSData: return jsonDataRepresentation(any)
    }
}

/**
 Create a purely dictionary representation of an array, int, complex object, etc
 
 - parameter any: any type
 
 - returns: any type - but should end in a dictionary
 */
func jsonDictionaryRepresentation<T>(any: T) -> Any {
    
    // first unwrap the value
    let any = unwrap(any)
    
    // detect the type
    let type: DisplayType = getDisplayType(any)
    
    switch type {
    case .Bool, .Int, .Float, .Double, .String, .NSNull, .NSValue:
        return any
    case .Array, .Set:
        
        // unwrap all optional values in the array
        let unwrapped = unwrapArray(any)
        var array:[AnyObject] = []
        
        // and form a new, array;
        // also go recurevly if it needs to be
        for object in unwrapped {
            if let result = jsonDictionaryRepresentation(object) as? AnyObject {
                array.append(result)
            }
        }
        
        // return value
        return array
    case .Dictionary:
        
        let mirroredAny = Mirror(reflecting: any)
        let dictionary = NSMutableDictionary()
        
        for (_, attribute) in mirroredAny.children.enumerate() {
            
            // get inner mirror
            let mirroredValue = Mirror(reflecting: attribute.value)
            
            // the key
            var setKey: String = ""
            var value: Any = 0
            
            for (i, attr) in mirroredValue.children.enumerate() {
                if (i % 2 == 0){
                    setKey = "\(attr.value)"
                }
                if (i % 2 == 1) {
                    value = unwrap(attr.value)
                }
            }
            
            // set the final result
            if let result = jsonDictionaryRepresentation(value) as? AnyObject {
                dictionary.setValue(result, forKey: setKey)
            }
        }
        
        // return
        return dictionary
    case .Class, .Struct:
        
        // use mirroring to create a dictionary from the object
        let mirroredAny = Mirror(reflecting: any)
        let dictionary = NSMutableDictionary()
        
        for (_, attr) in mirroredAny.children.enumerate() {
            
            if let label = attr.label as? String! {
                let value = unwrap(attr.value)
                if let result = jsonDictionaryRepresentation(value) as? AnyObject {
                    dictionary.setValue(result, forKey: label)
                }
            }
        }
        return dictionary
    case .Enum:
        return "\(any)" as AnyObject
    case .Tuple:
        
        // base data
        let mirroredAny = Mirror(reflecting: any)
        var array:[AnyObject] = []
        
        for (_, attr) in mirroredAny.children.enumerate() {
            if let value = unwrap(attr.value) as? AnyObject,
                let result = jsonDictionaryRepresentation(value) as? AnyObject {
                array.append(result)
            }
        }
        
        return array
    case .Optional, .Unknown:
        return any
    }
}

/**
 Private function that transforms a dictionary or array into a Json object
 
 - parameter any:     any type of object is alloweed as parameter, but in fact
                      only objects that are valid for Foundation's NSJSONSerialization
                      library will be processed
 - parameter options: preety printed or not
 
 - returns: a Json String
 */
func jsonStringRepresentation<T>(any: T, options: NSJSONWritingOptions) -> String {
    // initialize the string as an "empty" json, just in case parsing doesn' work
    var stringJson: NSString = NSString(string: "{}")
    var dataJson: NSData? = nil
    
    // go through all the motions of the parsing
    if let dictionary = jsonDictionaryRepresentation(any) as? AnyObject where
       NSJSONSerialization.isValidJSONObject(dictionary) {
        
        // finally try to parse
        do {
            dataJson = try NSJSONSerialization.dataWithJSONObject(dictionary, options: options)
            if let json = NSString(data: dataJson!, encoding: NSUTF8StringEncoding) {
                stringJson = json
            }
        }
        // error case 2: could not parse because of some serialization error
        catch {
            print("[Nosce :: Error] Variable given not dictionary or array")
        }
    }
    // error case 1: could not parse because json is not valid
    else {
        print("[Nosce :: Error] Variable given not dictionary or array")
    }
    
    // return value as String
    return stringJson as String
}

/**
 Public variant for the function above that returns a preety printed json
 
 - parameter any: an object conforming to the "Any" protocol
 
 - returns: a preety printed Json String
 */
func jsonStringPrettyRepresentation<T>(any: T) -> String {
    return jsonStringRepresentation(any, options: NSJSONWritingOptions.PrettyPrinted)
}

/**
 Public variant for the function above that returns a compactly printed json
 
 - parameter any: an object conforming to the "Any" protocol
 
 - returns: a compactly printed Json String
 */
func jsonStringCompactRepresentation<T>(any: T) -> String {
    return jsonStringRepresentation(any, options: NSJSONWritingOptions.init(rawValue: 0))
}

/**
 Public variant for the function above that returns a ns data object
 
 - parameter any: an object conforming to the "Any" protocol
 
 - returns: a nsdata object
 */
func jsonDataRepresentation<T>(any: T) -> NSData? {
    return jsonStringCompactRepresentation(any).dataUsingEncoding(NSUTF8StringEncoding)
}
