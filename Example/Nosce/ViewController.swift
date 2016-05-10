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
        
//        let mf1 = ["height":180,"width":380,"name":"mf.mp4"]
//        let mf2 = "{\"height\":180, \"width\":380, \"name\":\"mp3.mp4\"}"
//        
//        
//        let model = MediaFile()
//        let result1 = deserialize(model, json: mf1)
//        let result2 = deserialize(model, jsonString: mf2)
//        print(result1)
//        print(result2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createEnum<E: RawRepresentable>(rawValue: E.RawValue) -> E? {
        return E(rawValue: rawValue)
    }
    
    func printEnum<E: RawRepresentable>(value: E) -> AnyObject {
        if let result = value.rawValue as? AnyObject {
            return result
        }
        return NSNull()
    }
    
    func iterateEnum<T: Hashable>(_: T.Type) -> AnyGenerator<T> {
        var i = 0
        return AnyGenerator {
            let next = withUnsafePointer(&i) { UnsafePointer<T>($0).memory }
            return next.hashValue == i++ ? next : nil
        }
    }
}

