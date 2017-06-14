//
//  HourseOfOperation.swift
//  SmartCiti
//
//  Created by Sathish on 23/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import ObjectMapper

class HourseOfOperation: NSObject, Mappable {
    
    var weekDaysID: Int?
    var weekDays: String?
    var startTime: String?
    var endTime: String?
    var active: Bool?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        weekDaysID <- map["weekdays_id"]
        weekDays <- map["week_days"]
        startTime <- map["start_time"]
        endTime <- map["end_time"]
        active <- map["active"]
    }
}
