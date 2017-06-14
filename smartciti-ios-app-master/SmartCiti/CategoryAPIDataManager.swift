//
//  CategoryAPIDataManager.swift
//  SmartCiti
//
//  Created by Sathish on 18/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class CategoryAPIDataManager {
    
    class var sharedInstance: CategoryAPIDataManager {
        struct Static {
            static let instance = CategoryAPIDataManager()
        }
        return Static.instance
    }
    
    func getCategoryList(url: String, header: HTTPHeaders, parameters: Parameters, view: UIView, completion: @escaping(_ register: CategoryList, _ responseObject: Any) -> Void) -> Void {
        
        let categoryList = CategoryList()
        
        ServiceManager.sharedInstance.executeGetObjectURLEncoding(type: CategoryList.self, url: url, params: parameters, headers: header, view: view, completion: {
            response in
            
            let responseValue = response?.result.value
            
            if (response?.result.isSuccess)! {
                
                completion(categoryList, responseValue as Any)
                
            } else if(response?.result.isFailure)! {
                
                completion(categoryList, responseValue as Any)
                
            }
            
        })
    }
}
