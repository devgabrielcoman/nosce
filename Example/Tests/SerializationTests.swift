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
    
    func testSerializationSimple () {
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
    
    func testSerializationComplex () {
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
}
