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

        let j1 = "{\"name\":\"John\", \"age\":32, \"isActive\": 1}"
        let j2 = "{\"name\": \"Carry\", \"age\":18, \"isActive\": 1}"
        let j3 = "{\"name\":\"John&Carry Ltd.\", \"employees\":["+j1+","+j2+"]}"
        
        let e1 = Employee(jsonString: j1)
        let e2 = Employee(jsonString: j2)
        let com = Company(jsonString: j3)
        
        print(e1.dictionaryRepresentation())
        print(e2.dictionaryRepresentation())
        print(com.dictionaryRepresentation())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

