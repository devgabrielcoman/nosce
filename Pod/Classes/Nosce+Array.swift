//
//  Nosce+Array.swift
//  Pods
//
//  Created by Gabriel Coman on 29/05/2016.
//
//  
//  Module that adds serialization funcions for Arrays
//

import UIKit

// MARK: - Extension that provides the same serialization interface for Arrays
// as for objects
public extension Array {
    
    /**
     Function that adds the dictionary representation possibility to an array
     
     - returns: a NSArray of dictionaries (of objects submitted to the
     dictionaryRepresentation() function
     */
    public func dictionaryRepresentation () -> NSArray {
        
        var array = NSMutableArray()
        
        for item in self {
            if let item = item as? NosceSerializationProtocol {
                array.addObject(item.dictionaryRepresentation())
            }
        }
        
        if array.count > 0 {
            return array
        }
        else if let arraySelf = self as? NSArray {
            return arraySelf
        }
        else {
            return NSArray()
        }
    }
    
    /**
     function that returns a preety string representation from an array
     
     - returns: a json string representation of the array
     */
    public func jsonPrettyStringRepresentation() -> String? {
        let dictionary = dictionaryRepresentation()
        if NSJSONSerialization.isValidJSONObject(dictionary) {
            do {
                let json = try NSJSONSerialization.dataWithJSONObject(dictionary, options: .PrettyPrinted)
                return String(data: json, encoding: NSUTF8StringEncoding)
            } catch {
                return nil
            }
            
        }
        return nil
    }
    
    /**
     Same as above, but compact
     
     - returns: a compact json string representation of the array
     */
    public func jsonCompactStringRepresentation() -> String? {
        let dictionary = dictionaryRepresentation()
        if NSJSONSerialization.isValidJSONObject(dictionary) {
            do {
                let json = try NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions(rawValue: 0))
                return String(data: json, encoding: NSUTF8StringEncoding)
            } catch {
                return nil
            }
        }
        return nil
    }
    
    /**
     Same as above, but with NSData as return
     
     - returns: nsdata
     */
    public func jsonDataRepresentation() -> NSData? {
        let dictionary = dictionaryRepresentation()
        if NSJSONSerialization.isValidJSONObject(dictionary) {
            do {
                let json = try NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions(rawValue: 0))
                return json
            } catch {
                return nil
            }
        }
        return nil
    }
}

