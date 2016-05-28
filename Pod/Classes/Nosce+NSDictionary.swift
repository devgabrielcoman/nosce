//
//  Nosce+NSDictionary.swift
//  Pods
//
//  Created by Gabriel Coman on 28/05/2016.
//
//

import UIKit

public extension NSDictionary {
    static func dictionaryWithJsonData(jsonData: NSData) -> NSDictionary {
        do {
            let dict = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
            if let dict = dict as? NSDictionary {
                return dict
            }
        } catch let error as NSError {
            print("[Nosce] :: Error => Serialization error \(error)")
        }
        return NSDictionary()
    }
    
    static func dictionaryWithJsonString(jsonString: String) -> NSDictionary {
        let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding)
        if let jsonData = jsonData {
            return dictionaryWithJsonData(jsonData)
        }
        return NSDictionary()
    }
}