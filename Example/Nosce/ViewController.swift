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
        
//        let format = Format.Json;
//        
//        let m = Mirror(reflecting: format)
        
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

