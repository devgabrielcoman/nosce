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
        
//        let f1: Format = .XML
////        let f2: Format = .Json
////        let f3: Format = .CSV
////        print("\(f1) - \(f2) - \(f3)")
////        print("\(f1.hashValue) - \(f2.hashValue) - \(f3.hashValue)")
////        let f5: Format = Format(rawValue: 2)!
////        print(f5)
//        
//        let p:Process = .Direct
////        print(p)
////        print(p.rawValue)
////        let pp = Process(rawValue: "Indirect")!
////        print(pp)
//        
//        printEnum(f1)
//        printEnum(p)
//        
//        let m: MediaFile = MediaFile()
//        let x: Int = 32
//        let y: String = "abc"
//        let ubu = ["abc", "def"]
//        let xoxo = [0:"abc", 1:"ref"]
//        print(displayStyle(f1))
//        print(displayStyle(m))
//        print(displayStyle(x))
//        print(displayStyle(y))
//        print(displayStyle(ubu))
//        print(displayStyle(xoxo))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createEnum<E: RawRepresentable>(rawValue: E.RawValue) -> E? {
        return E(rawValue: rawValue)
    }
    
    func printEnum<E: RawRepresentable>(value: E) {
        print(value.rawValue)
    }

}

