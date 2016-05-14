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
        
        let mi = Process.Direct;
        let mi2 = Mirror(reflecting: mi)
        print(mi2)
        print(mi2.subjectType)
        for (_, atr) in mi2.children.enumerate() {
            print(atr)
        }
        
        let t = Temp()
        let mi3 = Mirror(reflecting: t)
        t.self.dynamicType.init()
        print(mi3.subjectType)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func test<E>(any: E) -> Void {
        print(any as! Int)
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

