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
//  with the "dictionaryRepresentation<T>(any: T)" function you can take any
//  model object and have it's dictionary representation generated
//
//  with the "jsonStringRepresentation<T>(any:T)" function you can take that
//  dictionary representation and transform it into a valid Json, if the
//  dictionary is valid as well
//

import UIKit

/**
 Create a purely dictionary representation of an array, int, complex object, etc
 
 - parameter any: any type
 
 - returns: any type - but should end in a dictionary
 */
public func dictionaryRepresentation<T>(any: T) -> Any {

    // first unwrap the value
    let any = unwrap(any)
    
    // then detect the type
    let type: DetectedType = getDetectedType(any)
    
    switch type {
    // in case it's an Int, Bool, etc, just return the unwrapped value
    case .NonHandledType:
        return any
        break
    // in case of array
    case .ArrayType, .SetType:
        // unwrap all optional values in the array
        let unwrapped = unwrapArray(any)
        var array:[AnyObject] = []
        
        // and form a new, array; 
        // also go recurevly if it needs to be
        for object in unwrapped {
            if let result = dictionaryRepresentation(object) as? AnyObject {
                array.append(result)
            }
        }
        return array
        break
    // in case of dictionary
    case .DictionaryType:
        // check if the dictionary is a "simple" nsdictionary
        if let anyDictionary = any as? NSDictionary {
            
            // for the return value
            var dictionary = NSMutableDictionary()
            
            for key in anyDictionary.allKeys {
                // get the new key as string (even if into or other type), 
                // so that it goes well with JSON
                let setKey = "\(key)" as String
                
                // get the initial value
                let value = anyDictionary.objectForKey(key)
                
                // and set the result
                if let result = dictionaryRepresentation(value) as? AnyObject {
                    dictionary.setValue(result, forKey: setKey)
                }
            }
            return dictionary
        }
        break
    // in case of more complex object
    case .CustomObjectType:
        
        // use mirroring to create a dictionary from the object
        let mirroredAny = Mirror(reflecting: any)
        var dictionary = NSMutableDictionary()
        
        for (_, attr) in mirroredAny.children.enumerate() {
            
            // must have a string type label
            // an unwrapped value (so as to either return the value or NSNull for
            // the destination dictionary)
            // and then go recurevely
            if let label = attr.label as? String!,
               let value = unwrap(attr.value) as? AnyObject,
               let result = dictionaryRepresentation(value) as? AnyObject {
                // finally set the value
                dictionary.setValue(result, forKey: label)
            }
        }
        return dictionary
        break
    }
    
    return any
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
    if let dictionary = dictionaryRepresentation(any) as? AnyObject where
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
public func jsonStringPrettyRepresentation<T>(any: T) -> String {
    return jsonStringRepresentation(any, options: NSJSONWritingOptions.PrettyPrinted)
}

/**
 Public variant for the function above that returns a compactly printed json
 
 - parameter any: an object conforming to the "Any" protocol
 
 - returns: a compactly printed Json String
 */
public func jsonStringCompactRepresentation<T>(any: T) -> String {
    return jsonStringRepresentation(any, options: NSJSONWritingOptions.init(rawValue: 0))
}

/**
 Public variant for the function above that returns a ns data object
 
 - parameter any: an object conforming to the "Any" protocol
 
 - returns: a nsdata object
 */
public func jsonDataRepresentation<T>(any: T) -> NSData? {
    return jsonStringCompactRepresentation(any).dataUsingEncoding(NSUTF8StringEncoding)
}
