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
        
        let xoxo = Array<Employee>(jsonDictionary: [0:"xoxox"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

