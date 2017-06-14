//
//  LogOut.swift
//  SmartCiti
//
//  Created by Sathish on 23/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import ObjectMapper

class LogOut: NSObject, Mappable {
    
    var status: Status?
    var entity: Entity?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        entity <- map["entity"]
    }
}
