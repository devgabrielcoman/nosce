//
//  TypeTests.swift
//  Nosce
//
//  Created by Gabriel Coman on 03/05/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import Nosce

class TypeTests: XCTestCase {

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
        let expected = DisplayType.Bool
        
        //
        // then
        let result = getDisplayType(given)
        XCTAssertEqual(result, expected)
    }
    
    func testInt() {
        //
        // given
        let given: Int = 32
        
        //
        // then
        let expected = DisplayType.Int
        
        //
        // when
        let result = getDisplayType(given)
        XCTAssertEqual(result, expected)
    }
    
    func testFloat () {
        //
        // given
        let given: Float = 31.5
        
        //
        // then
        let expected = DisplayType.Float
        
        //
        // when
        let result = getDisplayType(given)
        XCTAssertEqual(result, expected)
    }
    
    func testDouble () {
        //
        // given
        let given: Double = 39.95
        
        //
        // then
        let expected = DisplayType.Double
        
        //
        // when
        let result = getDisplayType(given)
        XCTAssertEqual(result, expected)
    }
    
    func testString () {
        //
        // given
        let given: String = "Test string"
        
        //
        // then
        let expected = DisplayType.String
        
        //
        // when
        let result = getDisplayType(given)
        XCTAssertEqual(result, expected)
    }
    
    func testArray () {
        //
        // given
        let given: [AnyObject] = ["Test one", 125]
        
        //
        // then
        let expected = DisplayType.Array
        
        //
        // when
        let result = getDisplayType(given)
        XCTAssertEqual(result, expected)
    }
    
    func testDictionry () {
        //
        // given
        let given: [Int:String] = [0: "Test one", 1: "Test two"]
        
        //
        // then
        let expected = DisplayType.Dictionary
        
        //
        // when
        let result = getDisplayType(given)
        XCTAssertEqual(result, expected)
    }
    
    func testSet () {
        //
        // given
        let given: NSSet = NSSet(objects: "Test one", 145)
        
        //
        // then
        let expected = DisplayType.Set
        
        //
        // when
        let result = getDisplayType(given)
        XCTAssertEqual(result, expected)
    }
    
    func testNSNull () {
        //
        // given
        let given: NSNull = NSNull()
        
        //
        // then
        let expected = DisplayType.NSNull
        
        //
        // when
        let result = getDisplayType(given)
        XCTAssertEqual(result, expected)
    }
    
    func testNSValue () {
        //
        // given
        let given: NSValue = NSValue(CGPoint: CGPointMake(-320, 125.5))
        
        //
        // then
        let expected = DisplayType.NSValue
        
        //
        // when
        let result = getDisplayType(given)
        XCTAssertEqual(result, expected)
    }
    
    func testStruct() {
        //
        // given
        let given: Temp = Temp(name: "Jimmy", startDate: 2015, willBePerm: true, benefits: [("medical", true),("helth", false)])
        
        //
        // then
        let expected = DisplayType.Struct
        
        //
        // when
        let result = getDisplayType(given)
        XCTAssertEqual(result, expected)
    }
    
    func testClass() {
        //
        // given
        let given = MediaFile(name: "78jkskja.mp4", width: 480, height: 320)
        
        //
        // then
        let expected = DisplayType.Class
        
        //
        // when
        let result = getDisplayType(given)
        XCTAssertEqual(result, expected)
    }
    
    func testTupe() {
        //
        // given
        let given1 = ("John", "Mayer")
        let given2 = (name: "James", surname: "Kilgo", age: 32)
        
        //
        // then
        let expected = DisplayType.Tuple
        
        //
        // when
        let result1 = getDisplayType(given1)
        let result2 = getDisplayType(given2)
        XCTAssertEqual(result1, expected)
        XCTAssertEqual(result2, expected)
    }
}
