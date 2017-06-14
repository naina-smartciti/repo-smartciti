//
//  UserType.swift
//  SmartCiti
//
//  Created by Sathish on 15/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import ObjectMapper

class UserType: NSObject, Mappable {
    
    var userTypeId: Int?
    var userTypeName: String?
    var authority: String?
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        userTypeId <- map["userTypeId"]
        userTypeName <- map["userTypeName"]
        authority <- map["authority"]
    }
}
