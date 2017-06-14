//
//  CategoryEntities.swift
//  SmartCiti
//
//  Created by Sathish on 15/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import ObjectMapper

class CategoryEntities: NSObject, Mappable {
    
    var categoryId: Int?
    var categoryName: String?
    var categoryImage: String?
    var categoryThumbnailImagePath: String?
    var categoryImagePath: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        categoryId <- map["category_id"]
        categoryName <- map["category_name"]
        categoryImage <- map["category_image"]
        categoryThumbnailImagePath <- map["thumbnailImagePath"]
        categoryImagePath <- map["imagePath"]
    }
}
