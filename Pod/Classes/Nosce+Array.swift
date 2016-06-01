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
     Init function for array from a Json Array containing values or dictionaries
     
     - parameter jsonArray: valid JSON array
     - parameter callback:  callback to work with
     
     - returns: a new array
     */
    public init <A>(jsonArray: AnyObject?, callback: (A) -> Element) {
        self.init ()
        
        if let jsonArray = jsonArray as? [AnyObject] {
            for item in jsonArray {
                if let item = item as? A {
                    self.append(callback(item))
                }
            }
        }
    }
    
    /**
     Init function for array from a Json Data object
     
     - parameter jsonData: NSData object containing valid array data
     - parameter callback: callback to work with
     
     - returns: a new array
     */
    public init <A> (jsonData: NSData, callback: (A) -> Element) {
        self.init()
        
        do {
            if let array = try NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as? [AnyObject] {
                for item in array {
                    if let item = item as? A {
                        let result = callback(item)
                        self.append(result)
                    }
                }
            }
        } catch {
            // do nothing
        }
    }
    
    /**
     Init function for array from a JSON string object
     
     - parameter jsonString: valid json string
     - parameter callback:   callback to work with
     
     - returns: a new array
     */
    public init <A> (jsonString: String, callback: (A) -> Element) {
        if let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
            self.init(jsonData: jsonData, callback: callback)
        } else {
            self.init()
        }
    }
    
    /**
     Function that adds the dictionary representation possibility to an array
     
     - returns: a NSArray of dictionaries (of objects submitted to the
     dictionaryRepresentation() function
     */
    public func dictionaryRepresentation () -> NSArray {
        
        let array = NSMutableArray()
        
        for item in self {
            if let item = item as? NosceSerializationProtocol where !(item is NSNull) {
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
    
    private func jsonData(array: NSArray, options: NSJSONWritingOptions) -> NSData? {
        if NSJSONSerialization.isValidJSONObject(array) {
            do {
                return try NSJSONSerialization.dataWithJSONObject(array, options: options)
            } catch {
                return nil
            }
        }
        return nil
    }
    
    /**
     function that returns a preety string representation from an array
     
     - returns: a json string representation of the array
     */
    public func jsonPrettyStringRepresentation() -> String? {
        let dictionary = dictionaryRepresentation()
        guard let json = jsonData(dictionary, options: .PrettyPrinted) else { return nil }
        return String(data: json, encoding: NSUTF8StringEncoding)
    }
    
    /**
     Same as above, but compact
     
     - returns: a compact json string representation of the array
     */
    public func jsonCompactStringRepresentation() -> String? {
        let dictionary = dictionaryRepresentation()
        guard let json = jsonData(dictionary, options: NSJSONWritingOptions(rawValue: 0)) else { return nil }
        return String(data: json, encoding: NSUTF8StringEncoding)
    }
    
    /**
     Same as above, but with NSData as return
     
     - returns: nsdata
     */
    public func jsonDataRepresentation() -> NSData? {
        let dictionary = dictionaryRepresentation()
        return jsonData(dictionary, options: NSJSONWritingOptions(rawValue: 0))
    }
}

