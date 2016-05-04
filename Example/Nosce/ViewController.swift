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
        
//        let bbb: Format = Format.XML
//        
//        let mimi = Mirror(reflecting: bbb)
//        print(mimi)
        
//        let modelClass = getClassNameAsString(bbb)
//        let modelClassName = NSClassFromString("\(modelClass)")
//        print(modelClassName)
//        if let modelClassName = NSClassFromString("\(modelClass)") as? Format.Type {
//            print(modelClassName)
//        }
        
//        let p: Process = Process.Indirect
//        
//        if let p = p.rawValue as? AnyObject {
//            
//        }
//        
//        for f in iterateEnum(p.dynamicType) {
//            print(f.rawValue)
//            
//            if f == p {
//                print("Found it!")
//            }
//        }
//        
//        let t = Process.Indirect
//        let u = t.dynamicType
//        for f in iterateEnum(u) {
//            print(f.rawValue)
//        }
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

