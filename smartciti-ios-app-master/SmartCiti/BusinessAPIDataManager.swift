//
//  BusinessAPIDataManager.swift
//  SmartCiti
//
//  Created by Sathish on 27/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class BusinessAPIDataManager {
    
    class var sharedInstance: BusinessAPIDataManager {
        struct Static {
            static let instance = BusinessAPIDataManager()
        }
        return Static.instance
    }
    
    func createBusiness(url: String, businessParams: Parameters, businessHeader: HTTPHeaders, view: UIView, completion: @escaping() -> Void) -> Void {
        
    }
    
}
