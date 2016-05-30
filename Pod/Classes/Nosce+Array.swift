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
    
    /**
     Init function for array from a Json Array containing values or dictionaries
     
     - parameter jsonArray: valid JSON array
     - parameter callback:  callback to work with
     
     - returns: a new array
     */
    public init <A>(json: AnyObject?, callback: (A) -> Element) {
        self.init ()
        
        if let jsonArray = json as? [AnyObject] {
            
            for item in jsonArray {
                if let item = item as? A {
                    let result = callback(item)
                    self.append(result)
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
            let array = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
            if let jsonArray = array as? [AnyObject] {
                for item in jsonArray {
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
        let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding)
        if let jsonData = jsonData {
            self.init(jsonData: jsonData, callback: callback)
        } else {
            self.init()
        }
    }
}

