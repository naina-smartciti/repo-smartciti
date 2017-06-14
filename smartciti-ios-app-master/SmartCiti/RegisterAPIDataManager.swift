//
//  RegisterAPIDataManager.swift
//  SmartCiti
//
//  Created by Sathish on 18/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class RegisterAPIDataManager {
    
    class var sharedInstance: RegisterAPIDataManager {
        struct Static {
            static let instance = RegisterAPIDataManager()
        }
        return Static.instance
    }
    
    func registerUser(url: String, header: HTTPHeaders, parameters: Parameters, view: UIView, completion: @escaping(_ register: Register, _ responseObject: Any) -> Void) -> Void {
        
        let register = Register()
        
        ServiceManager.sharedInstance.executePostObjectURL(type: Register.self, url: url, params: parameters, headers: header, view: view, completion: { response -> Void in
            
            let responseValue = response?.result.value
            
            if (response?.result.isSuccess)! {
                
                completion(register, responseValue as Any)
                
            } else if(response?.result.isFailure)! {
                
                completion(register, responseValue as Any)
            }
            
        })
        
    }
}
