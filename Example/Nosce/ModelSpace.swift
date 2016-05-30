//
//  Parent.swift
//  Nosce
//
//  Created by Gabriel Coman on 23/04/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Nosce

struct Position : NosceSerializationProtocol, NosceDeserializationProtocol {
    var salary: Int?
    var name: String?
    
    init(name: String, salary: Int){
        self.name = name
        self.salary = salary
    }
    
    init(jsonDictionary: NSDictionary) {
        salary <- jsonDictionary["salary"]
        name <- jsonDictionary["name"]
    }
    
    func dictionaryRepresentation() -> NSDictionary {
        return [
            "name": name ?? NSNull(),
            "salary": salary ?? NSNull()
        ]
    }
}

class Person: NosceDeserializationProtocol, NosceSerializationProtocol {
    var name: String?
    var position: Position?
    
    init () {
        // 
    }
    
    required init(jsonDictionary: NSDictionary) {
        name <- jsonDictionary["name"]
        if let dict = jsonDictionary["position"] as? NSDictionary {
            position = Position(jsonDictionary: dict)
        }
    }
    
    func dictionaryRepresentation() -> NSDictionary {
        return [
            "name": name ?? NSNull(),
            "position": safe(position).dictionaryRepresentation()
        ]
    }
}

class Employee : NosceSerializationProtocol, NosceDeserializationProtocol {
    var name: String?
    var age: Int?
    var isActive: Bool = false
    var trusted: Bool?
    
    init() {
        // nothing
    }
    
    required init(jsonDictionary: NSDictionary) {
        name <- jsonDictionary["name"]
        age <- jsonDictionary["age"]
        isActive <- jsonDictionary["isActive"]
        trusted <- jsonDictionary["trusted"]
    }
    
    func dictionaryRepresentation() -> NSDictionary {
        return [
            "name": name ?? NSNull(),
            "age": age ?? NSNull(),
            "isActive": isActive,
            "trusted": trusted ?? NSNull()
        ];
    }
}

class Company : NosceDeserializationProtocol, NosceSerializationProtocol {
    var name: String?
    var employees: [Employee] = []
    var seniors: [String] = []
    
    init () {
        // nothing
    }
    
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
            "name": name ?? NSNull(),
            "employees": employees.dictionaryRepresentation(),
            "seniors": seniors => { (name: String) -> String in
                return name
            }
            // optional
            // "seniors": seniors.dictionaryRepresentation()
        ]
    }
}