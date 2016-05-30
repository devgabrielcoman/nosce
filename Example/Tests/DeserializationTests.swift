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
    
    func testDeserializationSimple () {
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
        let result = Employee(jsonString: given)
        XCTAssertTrue(result.dictionaryRepresentation().isEqualToDictionary(expected))
    }
    
    func testDeserializationComplex () {
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
        let result = Company(jsonString: given)
        XCTAssertTrue(result.dictionaryRepresentation().isEqualToDictionary(expected))
    }
}
