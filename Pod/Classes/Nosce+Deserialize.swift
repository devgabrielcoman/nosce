//
//  Nosce+Deserialize.swift
//  Pods
//
//  Created by Gabriel Coman on 24/04/2016.
//  You can contact me at dev.gabriel.coman@gmail.com
//

import UIKit

public protocol NosceDeserializationProtocol {
    init(jsonString: String)
    init(jsonData: NSData)
    init(jsonDictionary: NSDictionary)
    func isValid() -> Bool
}

public extension NosceDeserializationProtocol {
    init(jsonString: String) {
        let jsonDictionary = NSDictionary.dictionaryWithJsonString(jsonString)
        self.init(jsonDictionary: jsonDictionary)
    }
    
    init(jsonData: NSData) {
        let jsonDictionary = NSDictionary.dictionaryWithJsonData(jsonData)
        self.init(jsonDictionary: jsonDictionary)
    }
    
    func isValid () -> Bool {
        return true
    }
}
