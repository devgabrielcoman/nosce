//
//  Parent.swift
//  Nosce
//
//  Created by Gabriel Coman on 23/04/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import EVReflection

class AdUnit: NSObject {
    var name: String = ""
    var creative: Creative = Creative()
    
    required override init(){
        super.init()
    }
    
    convenience init(name: String, creative: Creative) {
        self.init()
        self.name = name
        self.creative = creative
    }
}

class Creative: NSObject {
    var name: String = ""
    var order: Int = 0
    var mediaFiles: [MediaFile] = []
    
    required override init(){
        super.init()
    }
    
    convenience init (name: String, order: Int , mediaFiles: [MediaFile]) {
        self.init()
        self.name = name
        self.order = order
        self.mediaFiles = mediaFiles
    }
}

class MediaFile: NSObject {
    var name: String = ""
    var width: Int = 0
    var height: Int = 0
    
    required override init() {
        super.init()
    }
    
    convenience init(name: String, width: Int, height: Int) {
        self.init()
        self.name = name
        self.width = width
        self.height = height
    }
}

class Location: NSObject {
    var lat: Double = 0
    var lng: Double = 0
    
    required override init() {
        super.init()
    }
    
    convenience init(lat: Double, lng:Double){
        self.init()
        self.lat = lat;
        self.lng = lng;
    }
}

class Restaurant: NSObject {
    var name: String = ""
    var rating: Float = 0
    var location: Location = Location()
    
    required override init() {
        super.init()
    }
    
    convenience init(name: String, rating: Float, location: Location) {
        self.init()
        self.name = name
        self.rating = rating
        self.location = location
    }
}