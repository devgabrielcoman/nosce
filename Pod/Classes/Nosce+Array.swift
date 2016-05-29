//
//  Nosce+Array.swift
//  Pods
//
//  Created by Gabriel Coman on 29/05/2016.
//
//

import UIKit

public extension Array {
    
    public func dictionaryRepresentation () -> NSArray {
        
        var array = NSMutableArray()
        
        for item in self {
            if let item = item as? NosceSerializationProtocol {
                array.addObject(item.dictionaryRepresentation())
            }
        }
        
        if array.count > 0 {
            return array
        }
        else if let arraySelf = self as? NSArray {
            return arraySelf
        }
        else {
            return NSArray()
        }
    }
}

