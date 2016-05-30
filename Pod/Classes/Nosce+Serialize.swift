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
    
    // default implementation
    func jsonPrettyStringRepresentation () -> String? {
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
    
    // default implementation
    func jsonCompactStringRepresentation () -> String? {
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
    
    // default implementation
    func jsonDataRepresentation () -> NSData? {
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