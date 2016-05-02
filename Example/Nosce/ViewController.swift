//
//  ViewController.swift
//  Nosce
//
//  Created by Gabriel Coman on 03/01/2016.
//  Copyright (c) 2016 Gabriel Coman. All rights reserved.
//

import UIKit
import Nosce

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //
        // Test data
        let boolTest:Bool = false
        let uIntTest:UInt8 = 48
        let intTest:Int = -256
        let floatTest:Float = 3.14158921
        let stringTest: String = "Custom string"
        let numberTest:NSNumber = NSNumber(double: 3.125)
        let valueTest:NSValue = NSValue(CGPoint: CGPointMake(-125.3, 77.128))
        let arrayTest1:[String] = ["One value", "Two values", "Three values"]
        let arrayTest2 = ["One value", 128, 55]
        let arrayTest3:[AnyObject?] = ["One value", 22, nil, 48, nil, ["one":"two"]]
        let dictionaryTest1 = ["first": 128, "second": "Two values"]
        let dictioanryTest2 = [0: "One", 1: "Two"]
        let mediaFile1 = MediaFile(name: "test.mp4", width: 640, height: 480)
        let mediaFile2 = MediaFile(name: "example.mp4", width: 240, height: 180)
        let creative = Creative(name: "First creative", order: 0, mediaFiles: [mediaFile1, mediaFile2])
        let ad = AdUnit(name: "Zinger's costo play", creative: creative)
        let restaurant = Restaurant(name: "Papa John's", rating:3.5, location: Location(lat: 0.789212, lng: -12.92219))
        let restaurantArray = [restaurant]
        
        //
        // perform simple test
        print("Test 1")
        print("--------------------------------------------------------------")
        print(dictionaryRepresentation(boolTest))
        print(dictionaryRepresentation(uIntTest))
        print(dictionaryRepresentation(intTest))
        print(dictionaryRepresentation(floatTest))
        print(dictionaryRepresentation(stringTest))
        print(dictionaryRepresentation(numberTest))
        print(dictionaryRepresentation(valueTest))
        print(dictionaryRepresentation(arrayTest1))
        print(dictionaryRepresentation(arrayTest2))
        print(dictionaryRepresentation(arrayTest3))
        print(dictionaryRepresentation(dictionaryTest1))
        print(dictionaryRepresentation(dictioanryTest2))
        print(dictionaryRepresentation(mediaFile1))
        print(dictionaryRepresentation(mediaFile2))
        print(dictionaryRepresentation(creative))
        print(dictionaryRepresentation(ad))
        print(dictionaryRepresentation(restaurant))
        print(dictionaryRepresentation(restaurantArray))
        print("--------------------------------------------------------------")
        print("Test 2")
        print("--------------------------------------------------------------")
        print(jsonStringPrettyRepresentation(boolTest))
        print(jsonStringPrettyRepresentation(uIntTest))
        print(jsonStringPrettyRepresentation(intTest))
        print(jsonStringPrettyRepresentation(floatTest))
        print(jsonStringPrettyRepresentation(stringTest))
        print(jsonStringPrettyRepresentation(numberTest))
        print(jsonStringPrettyRepresentation(valueTest))
        print(jsonStringPrettyRepresentation(arrayTest1))
        print(jsonStringPrettyRepresentation(arrayTest2))
        print(jsonStringPrettyRepresentation(arrayTest3))
        print(jsonStringPrettyRepresentation(dictionaryTest1))
        print(jsonStringPrettyRepresentation(dictioanryTest2))
        print(jsonStringPrettyRepresentation(mediaFile1))
        print(jsonStringPrettyRepresentation(mediaFile2))
        print(jsonStringPrettyRepresentation(creative))
        print(jsonStringPrettyRepresentation(ad))
        print(jsonStringPrettyRepresentation(restaurant))
        print(jsonStringPrettyRepresentation(restaurantArray))
    
        print("--------------------------------------------------------------")
        print("Test 2")
        print("--------------------------------------------------------------")
        
        let networkDict = dictionaryRepresentation(restaurant) as! NSDictionary
        let networkDict2 = dictionaryRepresentation(ad) as! NSDictionary
        let networkArray = dictionaryRepresentation(restaurantArray)
        
        let deserialized = deserialize(Restaurant(), json: networkDict)
        let deserialized2 = deserialize([Restaurant()], json: networkArray)
        let deserialized3 = deserialize(AdUnit(), json: networkDict2)
        
        print(jsonStringPrettyRepresentation(deserialized))
        print(jsonStringPrettyRepresentation(deserialized2))
        print(jsonStringPrettyRepresentation(deserialized3))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

