//
//  SerializationTests.swift
//  Nosce
//
//  Created by Gabriel Coman on 02/05/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import XCTest
import Nosce

/// Class containing a series of tests for serialization
class SerializationTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSerializationSimpleStruct () {
        // given
        let given = Position(name: "Manager", salary: 32000)
        
        // when
        let expected = ["name": "Manager", "salary": 32000]
        
        // then
        let result = given.dictionaryRepresentation()
        XCTAssertTrue(result.isEqualToDictionary(expected))
    }
    
    func testSerializationSimpleModel () {
        // given
        let given = Employee()
        given.name = "John"
        given.age = 32
        given.isActive = true
        given.trusted = nil
        
        // when
        let expected = [
            "name": "John",
            "age": 32,
            "isActive": true,
            "trusted": NSNull()
        ]
        
        // then
        let result = given.dictionaryRepresentation()
        XCTAssertTrue(result.isEqualToDictionary(expected))
    }
    
    func testSerializationComplexModel1 () {
        // given
        let given1 = Employee()
        given1.name = "John"
        given1.age = 18
        given1.isActive = true
        given1.trusted = true
        let given2 = Employee()
        given2.name = "Anne"
        given2.age = 20
        given2.isActive = false
        given2.trusted = nil
        let given = Company()
        given.name = "John&Anne Ltd."
        given.employees = [given1, given2]
        given.seniors = ["Harry", "Lloyd"]
        
        // when
        let expected = [
            "name": "John&Anne Ltd.",
            "seniors": ["Harry", "Lloyd"],
            "employees": [
                [
                    "name": "John",
                    "age": 18,
                    "isActive": true,
                    "trusted": true
                ],
                [
                    "name": "Anne",
                    "age": 20,
                    "isActive": false,
                    "trusted": NSNull()
                ]
            ]
        ]
        
        // then
        let result = given.dictionaryRepresentation()
        XCTAssertTrue(result.isEqualToDictionary(expected))
    }
    
    func testSerializationComplexModel2 () {
        // given
        let given1 = Position(name: "CEO", salary: 100000)
        let given = Person()
        given.name = "John Smith"
        given.position = given1
        
        // when
        let expected = [
            "name": "John Smith",
            "position": [
                "name": "CEO",
                "salary": 100000
            ]
        ]
        
        // then
        let result = given.dictionaryRepresentation()
        XCTAssertTrue(result.isEqualToDictionary(expected))
    }
    
    func testSimpleArray () {
        // given
        let given = [1, "nosce", NSNull(), "fourth"]
        
        // when
        let expected = [1, "nosce", NSNull(), "fourth"]
        
        // then
        let result = given.dictionaryRepresentation()
        XCTAssertTrue(result.isEqualToArray(expected))
    }
    
    func testComplexArray () {
        // given
        let given1 = Position(name: "CEO", salary: 100000)
        let given2 = Position(name: "Engineer", salary: 35000)
        let given3 = Position(name: "Accountant", salary: 28000)
        let given = [given1, given2,  given3]
        
        // when
        let expected = [
            ["name": "CEO", "salary": 100000],
            ["name": "Engineer", "salary": 35000],
            ["name": "Accountant", "salary": 28000]
        ]
        
        // then
        let result = given.dictionaryRepresentation()
        XCTAssertTrue(result.isEqualToArray(expected))
    }
}
