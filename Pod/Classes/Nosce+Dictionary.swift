//
//  Nosce+Dictionary.swift
//  Pods
//
//  Created by Gabriel Coman on 31/05/2016.
//
//

import UIKit

public extension Dictionary {

    /**
     Inits with a dictionary
     
     - parameter jsonDictionary: basically copies the values
     
     - returns: a new self
     */
    public init(jsonDictionary: Dictionary) {
        self.init()
        for (key, value) in jsonDictionary {
            self[key] = value
        }
    }
    
    /**
     Inits with json data object
     
     - parameter jsonData: json data object
     
     - returns: self
     */
    public init(jsonData: NSData) {
        self.init()
        do {
            if let dictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.init(rawValue: 0)) as? Dictionary<Key, Value> {
                for (key, value) in dictionary {
                    self[key] = value
                }
            }
        } catch {
            // do nothing
        }
    }
    
    /**
     Inits with json string
     
     - parameter jsonString: a valid json string
     
     - returns: self
     */
    public init(jsonString: String) {
        if let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
            self.init(jsonData: data)
        } else {
            self.init()
        }
    }
    
    /**
     Dictionary representation of the dictionary
     
     - returns: just returns self
     */
    public func dictionaryRepresentation () -> Dictionary {
        return self
    }
    
    /**
     Json string (pretty) representation
     
     - returns: the json preety representation (if nsdictionary)
     */
    public func jsonPreetyStringRepresentation () -> String? {
        guard let dictionarySelf = self as? NSDictionary else { return nil }
        return dictionarySelf.jsonPreetyStringRepresentation()
    }
    
    /**
     Json string (compact) representation
     
     - returns: the json compact representation (if nsdictionary)
     */
    public func jsonCompactStringRepresentation () -> String? {
        guard let dictionarySelf = self as? NSDictionary else { return nil }
        return dictionarySelf.jsonCompactStringRepresentation()
    }
    
    /**
     Json data representation
     
     - returns: the json data representation (if nsdictionary)
     */
    public func jsonDataRepresentation () -> NSData? {
        guard let dictionarySelf = self as? NSDictionary else { return nil }
        return dictionarySelf.jsonDataRepresentation()
    }
}