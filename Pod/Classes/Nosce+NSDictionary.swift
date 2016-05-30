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
     Factory function that inits a dictionary from a NSData json object
     
     - parameter jsonData: a dictionary as NSData
     
     - returns: a valid NSDictionary object
     */
    static func dictionaryWithJsonData(jsonData: NSData) -> NSDictionary {
        do {
            let dict = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
            if let dict = dict as? NSDictionary {
                return dict
            }
        } catch let error as NSError {
            
        }
        return NSDictionary()
    }
    
    /**
     Factory function that inits a dictionary from a String json object
     
     - parameter jsonString: the json string
     
     - returns: the valid NSDictionary object
     */
    static func dictionaryWithJsonString(jsonString: String) -> NSDictionary {
        let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding)
        if let jsonData = jsonData {
            return dictionaryWithJsonData(jsonData)
        }
        return NSDictionary()
    }
}