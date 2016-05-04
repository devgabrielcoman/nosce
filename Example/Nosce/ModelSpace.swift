//
//  Parent.swift
//  Nosce
//
//  Created by Gabriel Coman on 23/04/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

public struct Temp {
    var name: String?
    var startDate: Int?
    var willBePerm: Bool = false
}

public class AdUnit: NSObject {
    var name: String = ""
    var creative: Creative = Creative()
    
    required override public init(){
        super.init()
    }
    
    convenience init(name: String, creative: Creative) {
        self.init()
        self.name = name
        self.creative = creative
    }
}

public class Creative: NSObject {
    var name: String = ""
    var order: Int = 0
    var mediaFiles: [MediaFile] = []
    
    required override public  init(){
        super.init()
    }
    
    convenience init (name: String, order: Int , mediaFiles: [MediaFile]) {
        self.init()
        self.name = name
        self.order = order
        self.mediaFiles = mediaFiles
    }
}

public class MediaFile: NSObject {
    var name: String = ""
    var width: Int = 0
    var height: Int = 0
    
    required override public init() {
        super.init()
    }
    
    convenience init(name: String, width: Int, height: Int) {
        self.init()
        self.name = name
        self.width = width
        self.height = height
    }
}

public class Location: NSObject {
    var lat: Double = 0
    var lng: Double = 0
    
    required override public init() {
        super.init()
    }
    
    convenience init(lat: Double, lng:Double){
        self.init()
        self.lat = lat;
        self.lng = lng;
    }
}

public class Restaurant: NSObject {
    var name: String = ""
    var rating: Float = 0
    var location: Location = Location()
    
    required override public init() {
        super.init()
    }
    
    convenience init(name: String, rating: Float, location: Location) {
        self.init()
        self.name = name
        self.rating = rating
        self.location = location
    }
}

public class Employee: NSObject {
    var name: String?
    var salary: Int?
    var history: [[String:NSObject]] = []
    
    
    required override public init() {
        super.init()
    }
    
    convenience init(name: String, salary: Int?) {
        self.init()
        self.name = name
        self.salary = salary
    }
    
    public func addHistory(employment: Employment, time: TimeFrame) {
        let dict:[String:NSObject] = [
            "employer": employment,
            "time": time
        ]
        history.append(dict)
    }
}

public class Employment: NSObject {
    var name: String = ""
    var address: String?
    
    required override public init() {
        super.init()
    }
    
    convenience init(name: String, address: String?) {
        self.init()
        self.name = name
        self.address = address
    }
}

public class TimeFrame: NSObject {
    var startYear: Int = 0
    var endYear: Int?
    var isCurrent: Bool = true
    
    required override public init() {
        super.init()
    }
    
    convenience init(startYear: Int, endYear: Int?, isCurrent: Bool) {
        self.init()
        self.startYear = startYear
        self.endYear = endYear
        self.isCurrent = isCurrent
    }
}

public enum Format: Int {
    case Json
    case XML
    case CSV
}

public enum Process: String {
    case Direct = "Direct"
    case Indirect = "Indirect"
}

public class TextFormatter: NSObject {
    var format: Format?
    
    required override public init() {
        super.init()
    }
    
    convenience init(format: Format) {
        self.init()
        self.format = format
    }
}