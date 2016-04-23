//
//  Parent.swift
//  Nosce
//
//  Created by Gabriel Coman on 23/04/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class AdUnit: NSObject {
    var name: String = ""
    var creative: Creative?
    
    init(name: String, creative: Creative) {
        super.init()
        self.name = name
        self.creative = creative
    }
}

class Creative: NSObject {
    var name: String = ""
    var order: Int?
    var mediaFiles: [MediaFile] = []
    
    init (name: String, order: Int? , mediaFiles: [MediaFile]) {
        super.init()
        self.name = name
        self.order = order
        self.mediaFiles = mediaFiles
    }
}

class MediaFile: NSObject {
    var name: String = ""
    var width: Int = 0
    var height: Int = 0
    
    init(name: String, width: Int, height: Int) {
        super.init()
        self.name = name
        self.width = width
        self.height = height
    }
}