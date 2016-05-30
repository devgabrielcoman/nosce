//
//  Nosce+Deserialize.swift
//  Pods
//
//  Created by Gabriel Coman on 24/04/2016.
//  You can contact me at dev.gabriel.coman@gmail.com
//
//  Model that defines a common deserialization protocol

import UIKit

/**
 *  This protocol defines four functions needed to correctly deserialize
 */
public protocol NosceDeserializationProtocol {
    /**
     Init an object through a json dictionary object; does not have
     a default implementation
     
     - parameter jsonDictionary: a json dictionary object
     
     - returns: the object
     */
    init(json: NSDictionary)
    
    /**
     Init an object through a json String; has a default implementation
     
     - parameter jsonString: valid json string
     
     - returns: return the object
     */
    init(json: String)
    
    /**
     Init an object through a json data object; has a default implementation
     
     - parameter jsonData: json data object
     
     - returns: returns the object
     */
    init(json: NSData)
    
    /**
     If overriden, determines the minimum ammount of conditions needed for the
     deserialization to be valid (e.g. how many fields were there OK);
     has a default implementation
     
     - returns: true or false
     */
    func isValid() -> Bool
}

// MARK: - An extension for the above protocol that provides a default 
// implementation for most of the functions; Basically a user will only need
// to implement the jsonDictionary function
public extension NosceDeserializationProtocol {
    
    // default implementation
    init(json: String) {
        let jsonDictionary = NSDictionary.dictionaryWithJsonString(json)
        self.init(json: jsonDictionary)
    }
    
    // default implementation
    init(json: NSData) {
        let jsonDictionary = NSDictionary.dictionaryWithJsonData(json)
        self.init(json: jsonDictionary)
    }
    
    // default implementation
    func isValid () -> Bool {
        return true
    }
}
