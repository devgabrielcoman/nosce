//
//  Nosce.swift
//  Pods
//
//  Created by Gabriel Coman on 01/03/2016.
//
//

import UIKit
import Dollar

// 
// Nosce is a small library that uses reflection to print out the contents of
// model-type object
// ideal candidates are classes in the form:
//
//  class SomeModel {
//      var name: String;
//      var points: Int;
//  }
//
public class Nosce: NSObject {
    
    // 
    // succession of more specific printObject functions
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
    // this is the most generic of the printObject series function, and the one
    // that all the other rely on
    // @param subject - the reflecting "Any" type object that's going to be printed
    // @param alies - a human readable name for the Model being presented
    // @param tab - the number of indents to add
    // @param fields - the fields to take into account
    public static func printObject(reflecting subject: Any, alias _alias: String?, tab _tab: Int, fields _fields: [String]?) {
        // create the mirror
        let mirrored = Mirror(reflecting: subject)
        
        // sort out the tabs
        var tabs = ""
        for (var i = 0; i < _tab && _tab > 0; i++) {
            tabs += "\t"
        }
        
        // print object type
        if let alias = _alias {
            print(tabs + alias)
        } else {
            print(tabs + "\(subject.dynamicType)")
        }
        
        // case #1: when the fields object is not nil
        // in this case print the members, in the order they are given
        if let fields = _fields {
            $.each(fields) { (i, field: String) in
                for (_, attr) in mirrored.children.enumerate() {
                    if let property_name = attr.label as String! {
                        if property_name == field {
                            print(tabs + "\t\(property_name) = \(attr.value)")
                        }
                    }
                }
            }
        }
        // case #2: just iterate over the fields and print the members
        else {
            for (_, attr) in mirrored.children.enumerate() {
                if let property_name = attr.label as String! {
                    print(tabs + "\t\(property_name) = \(attr.value)")
                }
            }
        }
    }
}
