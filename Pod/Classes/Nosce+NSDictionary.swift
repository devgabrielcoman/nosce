//
//  Nosce+NSDictionary.swift
//  Pods
//
//  Created by Gabriel Coman on 28/05/2016.
//
//  Module that extends NSDictionary to contain some useful factory functions

import UIKit

public extension NSDictionary {
    
    /**
     Public init with a nsdictionary
     
     - parameter jsonDictionary: a json dictionary
     
     - returns: self
     */
    public convenience init(jsonDictionary: NSDictionary){
        self.init(dictionary: jsonDictionary)
    }
    
    /**
     Init from JSON data
     
     - parameter jsonData: json data object
     
     - returns: self
     */
    public convenience init(jsonData: NSData) {
        do {
            if let dictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.init(rawValue: 0)) as? NSDictionary {
                self.init(dictionary: dictionary)
            }
            else {
                self.init()
            }
        } catch {
            self.init()
        }
    }
    
    /**
     Init from JSON string
     
     - parameter jsonString: a valid json string
     
     - returns: self
     */
    public convenience init(jsonString: String) {
        if let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
            self.init(jsonData: data)
        } else {
            self.init()
        }
    }
    
    /**
     Private function to take raw data and transform it into a dictionary
     
     - parameter options: writing type
     
     - returns: json data object
     */
    private func jsonData (options: NSJSONWritingOptions) -> NSData? {
        if NSJSONSerialization.isValidJSONObject(self) {
            do {
                return try NSJSONSerialization.dataWithJSONObject(self, options: options)
            } catch {
                return nil
            }
        }
        return nil
    }
    
    /**
     Just return self
     
     - returns: the same dictionary
     */
    public func dictionaryRepresentation () -> NSDictionary {
        return self
    }
    
    /**
     Transform a dictionary into a json string
     
     - returns: a json string optional (preety)
     */
    public func jsonPreetyStringRepresentation () -> String? {
        guard let json = jsonData(.PrettyPrinted) else { return nil }
        return String(data: json, encoding: NSUTF8StringEncoding)
    }
    
    /**
     Transform a dictionary into a json string
     
     - returns: a json string optional (compact)
     */
    public func jsonCompactStringRepresentation () -> String? {
        guard let json = jsonData(NSJSONWritingOptions(rawValue: 0)) else { return nil }
        return String(data: json, encoding: NSUTF8StringEncoding)
    }
    
    /**
     Transform a dictionary into a json nsdata value
     
     - returns: json data
     */
    public func jsonDataRepresentation () -> NSData? {
        return jsonData(NSJSONWritingOptions(rawValue: 0))
    }
}