//
//  ParkingPriceDetail.swift
//  SmartCiti
//
//  Created by Sathish on 23/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import ObjectMapper

class ParkingPriceDetail: NSObject, Mappable {
  
    var parkingPriceId: Int?
    var startTime: String?
    var endTime: String?
    var parkingPrice: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        parkingPriceId <- map["parking_price_id"]
        startTime <- map["start_time"]
        endTime <- map["end_time"]
        parkingPrice <- map["parking_price"]
    }
}
