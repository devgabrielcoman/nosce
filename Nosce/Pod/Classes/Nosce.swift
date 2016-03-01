//
//  Nosce.swift
//  Pods
//
//  Created by Gabriel Coman on 01/03/2016.
//
//

import UIKit
import Dollar

public class Nosce: NSObject {
    
    //
    // the simplest printObject function, that just takes a subject and lists
    // its members and values
    public static func printObject(reflecting subject: Any) {
        printObject(reflecting: subject, alias: nil, tab: 0, fields: nil)
    }
    
    public static func printObject(reflecting subject: Any, alias _alias: String?) {
        printObject(reflecting: subject, alias: _alias, tab: 0, fields: nil)
    }
    
    public static func printObject(reflecting subject: Any, alias _alias: String?, tab _tab: Int) {
        printObject(reflecting: subject, alias: _alias, tab: _tab, fields: nil)
    }
    
    //
    // main print object function
    public static func printObject(reflecting subject: Any, alias _alias: String?, tab _tab: Int, fields _fields: [String]?) {
        let mirrored = Mirror(reflecting: subject)
        
        // sort out the tabs
        var tabs = ""
        for (var i = 0; i < _tab && _tab > 0; i++) {
            tabs += "\t"
        }
        
        // print object type
        if let alias = _alias {
            print(alias)
        } else {
            print(tabs + "\(subject.dynamicType)")
        }
        
        // print its members
        if let fields = _fields {
            for (_, attr) in mirrored.children.enumerate() {
                if let property_name = attr.label as String! {
                    if $.contains(fields, value: property_name) {
                        print(tabs + "\t\(property_name) = \(attr.value)")
                    }
                }
            }
        } else {
            for (_, attr) in mirrored.children.enumerate() {
                if let property_name = attr.label as String! {
                    print(tabs + "\t\(property_name) = \(attr.value)")
                }
            }
        }
    }
}
