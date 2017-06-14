//
//  Status.swift
//  SmartCiti
//
//  Created by Sathish on 15/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import ObjectMapper

class Status: NSObject, Mappable {
    var status: Int?
    var message: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["msg"]
    }
}
