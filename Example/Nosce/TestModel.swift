//
//  TestModel.swift
//  Nosce
//
//  Created by Gabriel Coman on 01/03/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class TestModel: NSObject {
    
    var var1: Int = 0
    var var2: String! = nil
    var var3: Int?
    
    init(var1 v1: Int, var2 v2: String) {
        super.init()
        var1 = v1;
        var2 = v2;
    }
}
