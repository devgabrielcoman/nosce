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
    
    func testBool() {
        //
        // given
        let given: Bool = true
        
        //
        // when
        let expected: Bool = true
        let invalid: Bool = false
        
        //
        // then
        guard let result = serialize(given, format: .toDictionary) as? Bool else { XCTFail("Bool test failed"); return; }
        XCTAssertEqual(result, expected)
        XCTAssertNotEqual(result, invalid)
    }
    
    func testInt() {
        //
        // given
        let given: Int = 32
        
        //
        // when
        let expected: Int = 32
        let invalid: Int = 41
        
        //
        // then
        guard let result = serialize(given, format: .toDictionary) as? Int else { XCTFail("Int test failed"); return; }
        XCTAssertEqual(result, expected)
        XCTAssertNotEqual(result, invalid)
    }
    
    func testFloat()  {
        //
        // given
        let given: Float = 25.5
        
        //
        // when
        let expected: Float = 25.5
        let invalid: Float = 15.127
        
        //
        // then
        guard let result = serialize(given, format: .toDictionary) as? Float else { XCTFail("Float test failed"); return; }
        XCTAssertEqual(result, expected)
        XCTAssertNotEqual(result, invalid)
    }
    
    func testNSNumber() {
        //
        // given
        let given = NSNumber(double: 32.5)
        
        //
        // when
        let expected: NSNumber = NSNumber(double: 32.5)
        let invalid: NSNumber = NSNumber(int: 128)
        
        //
        // then
        guard let result = serialize(given, format: .toDictionary) as? NSNumber else { XCTFail("NSNumber test failed"); return; }
        XCTAssertEqual(result, expected)
        XCTAssertNotEqual(result, invalid)
    }
    
    func testNSValue() {
        //
        // given
        let given: NSValue = NSValue(CGPoint: CGPointMake(-128.5, 0.38))
        
        //
        // when
        let expected: NSValue = NSValue(CGPoint: CGPointMake(-128.5, 0.38))
        let invalid: NSValue = NSValue(CGSize: CGSizeMake(-100, 32.5))
        
        //
        // then
        guard let result = serialize(given, format: .toDictionary) as? NSValue else { XCTFail("NSValue test failed"); return; }
        XCTAssertEqual(result, expected)
        XCTAssertNotEqual(result, invalid)
    }
    
    func testArrays() {
        //
        // given
        let given1:[String] = ["Test value 1", "Test value 1", "Test value 1"]
        let given2 = ["Test value 1", 128, 55]
        let given3:[AnyObject?] = ["Test value 1", 22, nil, 48, nil, ["one":"two"]]
        
        //
        // when
        let expected1 = [
            "Test value 1",
            "Test value 1",
            "Test value 1"
        ]
        let expected2 = [
            "Test value 1",
            128,
            55
        ]
        let expected3 = [
            "Test value 1",
            22,
            NSNull(),
            48,
            NSNull(),
            ["one":"two"]
        ]
        
        //
        // then
        guard let result1 = serialize(given1, format: .toDictionary) as? NSArray else { XCTFail("NSArray test 1 failed"); return; }
        guard let result2 = serialize(given2, format: .toDictionary) as? NSArray else { XCTFail("NSArray test 2 failed"); return; }
        guard let result3 = serialize(given3, format: .toDictionary) as? NSArray else { XCTFail("NSArray test 3 failed"); return; }
        XCTAssertEqual(result1, expected1)
        XCTAssertEqual(result2, expected2)
        XCTAssertEqual(result3, expected3)
    }
    
    func testDictionaries() {
        //
        // given
        let given1 = ["first": 128, "second": "Two values"]
        let given2 = [0: "One", 1: "Two"]
        let given3:[Int:String?] = [0: nil, 1: "Terry"]
        
        //
        // when
        let expected1 = [
            "first": 128,
            "second": "Two values"
        ]
        let expected2 = [
            "0":"One",
            "1":"Two"
        ]
        let expected3 = [
            "0":NSNull(),
            "1":"Terry"
        ]
        
        //
        // then
        guard let result1 = serialize(given1, format: .toDictionary) as? NSDictionary else { XCTFail("NSDictionary test 1 failed"); return; }
        guard let result2 = serialize(given2, format: .toDictionary) as? NSDictionary else { XCTFail("NSDictionary test 2 failed"); return; }
        guard let result3 = serialize(given3, format: .toDictionary) as? NSDictionary else { XCTFail("NSDictionary test 3 failed"); return; }
        XCTAssertEqual(result1, expected1)
        XCTAssertEqual(result2, expected2)
        XCTAssertEqual(result3, expected3)
    }
    
    func testStruct1() {
        //
        // given
        let given = Temp(name: "Jimmy", startDate: 2016, willBePerm: true)
        
        // when
        let expected = [
            "name": "Jimmy",
            "startDate": 2016,
            "willBePerm": true
        ]
        
        //
        // then
        guard let result = serialize(given, format: .toDictionary) as? NSDictionary else { XCTFail("Struct test failed"); return; }
        XCTAssertEqual(result, expected)
    }
    
    func testModels1() {
        //
        // given
        let given1 = MediaFile(name: "test.mp4", width: 640, height: 480)
        let given2 = MediaFile(name: "example.mp4", width: 240, height: 180)
        let given3 = Creative(name: "First creative", order: 0, mediaFiles: [given1, given2])
        let given4 = AdUnit(name: "Zinger's costo play", creative: given3)

        //
        // when
        let expected1 = [
            "name": "test.mp4",
            "width": 640,
            "height": 480
        ]
        let expected2 = [
            "name": "example.mp4",
            "width": 240,
            "height": 180
        ]
        let expected3 = [
            "name": "First creative",
            "order": 0,
            "mediaFiles": [expected1, expected2]
        ]
        let expected4 = [
            "name": "Zinger's costo play",
            "creative": expected3
        ]
        
        //
        // then
        guard let result1 = serialize(given1, format: .toDictionary) as? NSDictionary else { XCTFail("Model test 1 failed"); return; }
        guard let result2 = serialize(given2, format: .toDictionary) as? NSDictionary else { XCTFail("Model test 2 failed"); return; }
        guard let result3 = serialize(given3, format: .toDictionary) as? NSDictionary else { XCTFail("Model test 3 failed"); return; }
        guard let result4 = serialize(given4, format: .toDictionary) as? NSDictionary else { XCTFail("Model test 4 failed"); return; }
        XCTAssertEqual(result1, expected1)
        XCTAssertEqual(result2, expected2)
        XCTAssertEqual(result3, expected3)
        XCTAssertEqual(result4, expected4)
    }
    
    func testModels2() {
        //
        // given
        let given1 = Location(lat: 0.789212, lng: -12.92119)
        let given2 = Restaurant(name: "Papa John's", rating: 3.5, location: given1)
        
        //
        // when
        let expected1 = [
            "lat": 0.789212,
            "lng": -12.92119
        ]
        let expected2 = [
            "name": "Papa John's",
            "rating": 3.5,
            "location": expected1
        ]
        
        //
        // then
        guard let result1 = serialize(given1, format: .toDictionary) as? NSDictionary else { XCTFail("Model test 1 failed"); return; }
        guard let result2 = serialize(given2, format: .toDictionary) as? NSDictionary else { XCTFail("Model test 2 failed"); return; }
        XCTAssertEqual(result1, expected1)
        XCTAssertEqual(result2, expected2)
    }
    
    func testModels3() {
        //
        // given
        let given1 = AdUnit(name: "One ad", creative: Creative(name: "Image", order: 0, mediaFiles: [MediaFile(name: "test.mp4", width: 640, height: 480)]))
        let given2 = Restaurant(name: "Papa John", rating: 3.5, location: Location(lat: 0.1289992, lng: -0.21921921))
        
        //
        // when
        let expected1 = [
            "name": "One ad",
            "creative": [
                "name": "Image",
                "order": 0,
                "mediaFiles": [
                    [
                        "name":"test.mp4",
                        "width":640,
                        "height": 480
                    ]
                ]
            ]
        ]
        let expected2 = [
            "name": "Papa John",
            "rating": 3.5,
            "location":[
                "lat":0.1289992,
                "lng":-0.21921921
            ]
        ]
        
        //
        // then
        guard let result1 = serialize(given1, format: .toDictionary) as? NSDictionary else { XCTFail("Model test 1 failed"); return; }
        guard let result2 = serialize(given2, format: .toDictionary) as? NSDictionary else { XCTFail("Model test 2 failed"); return; }
        XCTAssertEqual(result1, expected1)
        XCTAssertEqual(result2, expected2)
    }
    
    func testModel4()  {
        //
        // given
        let given1 = Employment(name: "Startup Ltd.", address: nil)
        let given2 = Employment(name: "Corporation Ltd.", address: "Embankment No. 1")
        let given3 = TimeFrame(startYear: 2006, endYear: 2010, isCurrent: false)
        let given4 = TimeFrame(startYear: 2010, endYear: nil, isCurrent: true)
        let given5 = Employee(name: "John Smith", salary: 30000)
        given5.addHistory(given1, time: given3)
        given5.addHistory(given2, time: given4)
        
        //
        // when
        let expected = [
            "name": "John Smith",
            "salary": 30000,
            "history": [
                [
                    "employer": [
                        "name":"Startup Ltd.",
                        "address": NSNull()
                    ],
                    "time":[
                        "endYear": 2010,
                        "isCurrent": false,
                        "startYear": 2006
                    ]
                ],
                [
                    "employer": [
                        "name":"Corporation Ltd.",
                        "address":"Embankment No. 1"
                    ],
                    "time":[
                        "startYear": 2010,
                        "isCurrent": true,
                        "endYear": NSNull()
                    ]
                ]
            ]
        ]
        
        //
        // then
        guard let result = serialize(given5, format: .toDictionary) as? NSDictionary else { XCTFail("Model test failed"); return; }
        XCTAssertEqual(result, expected)
    }
    
    func testModel5() {
        //
        // given
        let given = TextFormatter(format: .XML)
        
        //
        // when
        
        //
        // then
        let result = serialize(given, format: .toDictionary)
        print(result)
    }
}
