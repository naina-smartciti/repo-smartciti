//
//  SearchCategory.swift
//  SmartCiti
//
//  Created by Sathish on 23/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchCategory: NSObject, Mappable {
    
    var status: Status?
    var businessEntity: BusinessEntity?
    var user: User?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        businessEntity <- map["entities"]
        user <- map["user_id"]
    }
}
