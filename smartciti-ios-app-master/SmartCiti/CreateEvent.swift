//
//  CreateEvent.swift
//  SmartCiti
//
//  Created by Sathish on 23/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import ObjectMapper

class CreateEvent: NSObject, Mappable {
    
    var status: Status?
    var eventEntity: EventEntity?
    var user: User?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        eventEntity <- map["entity"]
        user <- map["user"]
    }
}
