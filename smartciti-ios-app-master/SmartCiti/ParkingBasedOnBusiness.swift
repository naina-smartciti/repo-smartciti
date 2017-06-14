//
//  ParkingBasedOnBusiness.swift
//  SmartCiti
//
//  Created by Sathish on 23/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import ObjectMapper

class ParkingBasedOnBusiness: NSObject, Mappable{
    
    var status: Status?
    var entities: [ParkingEntity]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        entities <- map["entities"]
    }
}
