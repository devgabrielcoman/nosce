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
    
    func testModel1() {
        //
        // given
        let given = ["height":180,"width":380,"name":"mf.mp4"]
        
        //
        // expected
        let expected = ["height":180,"width":380,"name":"mf.mp4"]
        
        //
        // then
        let model = MediaFile()
        let modelResult = deserialize(model, jsonDict: given)
        guard let result = serialize(modelResult, format: .toDictionary) as? NSDictionary else { XCTFail("Model test failed"); return; }
        XCTAssertEqual(result, expected)
    }
    
    func testModel2() {
        //
        // given
        let given = "{\"height\":180, \"width\":380, \"name\":\"mp3.mp4\"}"
        
        //
        // expected
        let expected = ["height":180,"width":380,"name":"mp3.mp4"]
        
        //
        // then
        let model = MediaFile()
        let modelResult = deserialize(model, jsonString: given)
        guard let result = serialize(modelResult, format: .toDictionary) as? NSDictionary else { XCTFail("Model test failed"); return; }
        XCTAssertEqual(result, expected)
    }
    
    func testModel3() {
        //
        // given
        let given = "{\"name\":\"John\"}"
        
        //
        // expected
        let expected = ["name":"John"]
        
        //
        // then
        let modelResult = deserialize(NonNSObject(), jsonString: given)
        print(modelResult)
    }
}
