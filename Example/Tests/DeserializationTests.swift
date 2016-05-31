//
//  DeserializationTests.swift
//  Nosce
//
//  Created by Gabriel Coman on 02/05/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import Nosce

class DeserializationTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDeserializationSimpleStruct () {
        // given
        let given = "{ \"name\": \"Manager\", \"salary\": 32000 }"
   
        // when
        let expected = ["name":"Manager", "salary": 32000]
        
        // then
        let result = Position(json: given)
        XCTAssertTrue(result.dictionaryRepresentation().isEqualToDictionary(expected))
    }
    
    func testDeserializationSimpleModel () {
        // given
        let given = "{\"name\":\"John\", \"age\":28, \"isActive\": true, \"trusted\": false}"
        
        // when
        let expected = [
            "name": "John",
            "age": 28,
            "isActive": true,
            "trusted": false
        ]
        
        // then
        let result = Employee(json: given)
        XCTAssertTrue(result.dictionaryRepresentation().isEqualToDictionary(expected))
    }
    
    func testDeserializationComplexModel1 () {
        // given
        let given1 = "{ \"name\": \"John\", \"age\": 32, \"isActive\": true, \"trusted\": false }"
        let given2 = "{ \"name\": \"Anne\", \"age\": 18, \"isActive\": false, \"trusted\": null }"
        let given3 = "{ \"name\": \"Smith\", \"age\":40 }"
        let given = "{ \"name\": \"John Smith\", \"seniors\": [\"Henry\"], \"employees\": [\(given1), \(given2), \(given3)] }"
        
        // when
        let expected1 = ["name":"John", "age":32, "isActive": true, "trusted": false]
        let expected2 = ["name":"Anne", "age":18, "isActive": false, "trusted": NSNull()]
        let expected3 = ["name":"Smith", "age":40, "isActive": false, "trusted": NSNull()]
        let expected = [
            "name": "John Smith",
            "seniors": ["Henry"],
            "employees": [expected1, expected2, expected3]
        ]
        
        // then
        let result = Company(json: given)
        XCTAssertTrue(result.dictionaryRepresentation().isEqualToDictionary(expected))
    }
    
    func testDeserializationComplexModel2 () {
        // given
        let given1 = "{ \"name\": \"CEO\", \"salary\": 100000 }"
        let given = "{ \"name\": \"John Smith\", \"position\": \(given1) }"
        
        // expected
        let expected = [
            "name": "John Smith",
            "position": [
                "name": "CEO",
                "salary": 100000
            ]
        ]
        
        // then
        let result = Person(json: given)
        XCTAssertTrue(result.dictionaryRepresentation().isEqualToDictionary(expected))
    }
    
    func testSimpleArray () {
        // given
        let given = "[1, 32, 89, 12]"
        
        // expected
        let expected = [1, 32, 89, 12]
        
        // then
        let result = Array<Int>(json: given) { (value: Int) -> Int in
            return value
        }
        XCTAssertTrue(result.dictionaryRepresentation().isEqualToArray(expected))
    }
    
    func testComplexArray () {
        // given
        let given1 = "{ \"name\": \"CEO\", \"salary\": 100000 }"
        let given2 = "{ \"name\": \"Engineer\", \"salary\": 35000 } "
        let given = "[\(given1), \(given2)]"
        
        // expected
        let expected = [
            ["name": "CEO", "salary": 100000],
            ["name": "Engineer", "salary": 35000]
        ]
        
        // then
        let result = Array<Position>(json: given) { (dict: NSDictionary) -> Position in
            return Position(json: dict)
        }
        XCTAssertTrue(result.dictionaryRepresentation().isEqualToArray(expected))
    }
}
