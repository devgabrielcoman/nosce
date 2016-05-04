//
//  AuxTests.swift
//  Nosce
//
//  Created by Gabriel Coman on 03/05/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import Nosce

class AuxTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testClassNames() {
        //
        // given
        let given1: Bool = true
        let given2: Float = 3.14
        let given3: NSNull = NSNull()
        let given4: NSNumber = NSNumber(int: 328)
        let given5: AdUnit = AdUnit()
        
        //
        // when
        let expected1: String = "Bool"
        let expected2: String = "Float"
        let expected3: String = "NSNull"
        let expected4: String = "NSCFNumber"
        let expected5: String = "AdUnit"
        
        //
        // then
        let result1 = getClassNameAsString(given1)
        let result2 = getClassNameAsString(given2)
        let result3 = getClassNameAsString(given3)
        let result4 = getClassNameAsString(given4)
        let result5 = getClassNameAsString(given5)
        XCTAssertEqual(result1, expected1)
        XCTAssertEqual(result2, expected2)
        XCTAssertEqual(result3, expected3)
        XCTAssertEqual(result4, expected4)
        XCTAssertEqual(result5, expected5)
    }
    
    func testUnrwap () {
        //
        // given
        let given1: Int? = nil
        let given2: Float? = 32
        
        //
        // when
        let expected1 = NSNull()
        let expected2: Float = 32.0
        
        // 
        // then
        let result1 = unwrap(given1) as! NSNull
        let result2 = unwrap(given2) as! Float
        XCTAssertEqual(result1, expected1)
        XCTAssertEqual(result2, expected2)
    }
}
