//
//  Nosce3.swift
//  Pods
//
//  Created by Gabriel Coman on 23/04/2016.
//  You can contact me at dev.gabriel.coman@gmail.com
//
//  Module that defines a common serialization protocol

import UIKit

/**
 *  Protocol that defines a few functions that must be present for 
 *  serialization to be ok
 */
public protocol NosceSerializationProtocol {
    /**
     Function that provides a json dictionary representation for a certain model
     
     - returns: a NSDictionary object
     */
    func dictionaryRepresentation () -> NSDictionary
    
    /**
     Function that provides a json preety string representation for a 
     certain model; has a default implementation
     
     - returns: an optional String value
     */
    func jsonPrettyStringRepresentation () -> String?
    
    /**
     Function that provides a json compact representation for a certain model;
     has a default implementation
     
     - returns: an optional String value
     */
    func jsonCompactStringRepresentation () -> String?
    
    /**
     Function that provides a nsdata compact representation for a certain model;
     has a default implementation
     
     - returns: a NSData object
     */
    func jsonDataRepresentation () -> NSData?
}

// MARK: - Extension for the above protocol that adds a number of default
// implementations for most of the functions
public extension NosceSerializationProtocol {
    
    private func jsonData(options: NSJSONWritingOptions) -> NSData? {
        let dictionary = dictionaryRepresentation()
        if NSJSONSerialization.isValidJSONObject(dictionary) {
            do {
                return try NSJSONSerialization.dataWithJSONObject(dictionary, options: options)
            } catch {
                return nil
            }
        }
        return nil
    }
    
    // default implementation
    func jsonPrettyStringRepresentation () -> String? {
        guard let json = jsonData(.PrettyPrinted) else { return nil }
        return String(data: json, encoding: NSUTF8StringEncoding)
    }
    
    // default implementation
    func jsonCompactStringRepresentation () -> String? {
        guard let json = jsonData(NSJSONWritingOptions(rawValue: 0)) else { return nil }
        return String(data: json, encoding: NSUTF8StringEncoding)
    }
    
    // default implementation
    func jsonDataRepresentation () -> NSData? {
        return jsonData(NSJSONWritingOptions(rawValue: 0))
    }
}