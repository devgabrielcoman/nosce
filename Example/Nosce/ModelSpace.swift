//
//  Parent.swift
//  Nosce
//
//  Created by Gabriel Coman on 23/04/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Nosce

class Employee : NosceSerializationProtocol, NosceDeserializationProtocol {
    var name: String?
    var age: Int?
    var isActive: Bool = false
    
    required init(jsonDictionary: NSDictionary) {
        name <- jsonDictionary["name"]
        age <- jsonDictionary["age"]
        isActive <- jsonDictionary["isActive"]
    }
    
    func dictionaryRepresentation() -> NSDictionary {
        return [
            "name": name ?? NSNull(),
            "age": age ?? NSNull(),
            "isActive": isActive
        ];
    }
}

class Company : NosceDeserializationProtocol, NosceSerializationProtocol {
    var name: String?
    var employees: [Employee] = []
    var seniors: [String] = []
    
    required init(jsonDictionary: NSDictionary) {
        name <- jsonDictionary["name"]
        employees <- jsonDictionary["employees"] => { (dict: NSDictionary) -> Employee in
            return Employee(jsonDictionary: dict)
        }
        seniors <- jsonDictionary["seniors"] => { (name: String) -> String in
            return name
        }
    }
    
    func dictionaryRepresentation() -> NSDictionary {
        return [
            "name": unwrap(name),
            "employees": employees.dictionaryRepresentation(),
            "seniors": seniors => { (name: String) -> String in
                return name
            }
            // optional
            // "seniors": seniors.dictionaryRepresentation()
        ]
    }
}