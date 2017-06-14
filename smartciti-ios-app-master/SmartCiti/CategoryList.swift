//
//  CategoryList.swift
//  SmartCiti
//
//  Created by Sathish on 15/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import ObjectMapper

class CategoryList: NSObject, Mappable {
    
    var status: Status?
    var categoryEntities: [CategoryEntities]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        categoryEntities <- map["entities"]
    }
}
