//
//  AddBusiness.swift
//  SmartCiti
//
//  Created by Sathish on 23/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import ObjectMapper

class AddBusiness: NSObject, Mappable {
    
    var status: Status?
    var entity: BusinessEntity?
    var userId: User?
    var categoryId: CategoryID?
    var hourseOfOperation: [HourseOfOperation]?

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        status <- map["status"]
        entity <- map["entity"]
        categoryId <- map["category_id"]
        userId <- map["user_id"]
        hourseOfOperation <- map["hoursOfOperation"]
    }
}
