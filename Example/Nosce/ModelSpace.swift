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
    var isActive: Bool?
    
    init(name: String, age: Int, isActive: Bool) {
        self.name = name
        self.age = age
        self.isActive = isActive
    }
    
    required init(jsonDictionary: NSDictionary) {
        name <- jsonDictionary["name"]
        age <- jsonDictionary["age"]
        isActive <- jsonDictionary["isActive"]
    }
    
    func dictionaryRepresentation() -> NSDictionary {
        return [
            "name": name!,
            "age": age!,
            "isActive": isActive!
        ];
    }
    
    func isValid() -> Bool {
        return true
    }
}

class Company : NosceDeserializationProtocol, NosceSerializationProtocol {
    var name: String?
    var employees: [Employee] = []
    
    init(name: String, employees: [Employee]) {
        self.name = name
        self.employees = employees
    }
    
    required init(jsonDictionary: NSDictionary) {
        name <- jsonDictionary["name"]
        employees <- jsonDictionary["employees"] => { (dict: NSDictionary) -> Employee in
            return Employee(jsonDictionary: dict)
        }
    }
    
    func isValid() -> Bool {
        return true
    }
    
    func dictionaryRepresentation() -> NSDictionary {
        return [
            "name": name!,
            "employees": employees => { (employee: Employee) -> NSDictionary in
                return employee.dictionaryRepresentation ()
            }
        ]
    }
}