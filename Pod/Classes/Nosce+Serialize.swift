//
//  Nosce3.swift
//  Pods
//
//  Created by Gabriel Coman on 23/04/2016.
//  You can contact me at dev.gabriel.coman@gmail.com
//

import UIKit

public protocol NosceSerializationProtocol {
    func dictionaryRepresentation () -> NSDictionary
    func jsonPrettyStringRepresentation () -> String?
    func jsonCompactStringRepresentation () -> String?
    func jsonDataRepresentation () -> NSData?
}

public extension NosceSerializationProtocol {
    
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