//
//  CategoryID.swift
//  SmartCiti
//
//  Created by Sathish on 23/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import ObjectMapper

class CategoryID: NSObject, Mappable {
    
    var categoryID: Int?
    var categoryName: String?
    var categoryImage: String?
    var thumbnailImagePath: String?
    var imagePath: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        categoryID <- map["category_id"]
        categoryName <- map["category_name"]
        categoryImage <- map["category_image"]
        thumbnailImagePath <- map["thumbnailImagePath"]
        imagePath <- map["imagePath"]
        
    }
}
