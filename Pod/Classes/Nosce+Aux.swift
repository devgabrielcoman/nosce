//
//  Nosce+Aux.swift
//  Pods
//
//  Created by Gabriel Coman on 29/05/2016.
//
//  Module that defines an unwrap function for optional

import UIKit

extension NSNull: NosceSerializationProtocol {
    public func dictionaryRepresentation() -> NSDictionary {
        return NSDictionary()
    }
}

public func safe <T>(any: T?) -> NosceSerializationProtocol {
    if let any = any as? NosceSerializationProtocol {
        return any
    }
    return NSNull()
}