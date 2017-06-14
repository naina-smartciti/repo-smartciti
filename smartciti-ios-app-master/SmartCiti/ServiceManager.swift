//
//  ServiceManager.swift
//  SmartCiti
//
//  Created by Sathish on 06/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class ServiceManager: BaseViewController {
    
    class var sharedInstance: ServiceManager {
        struct Static {
            static let instance = ServiceManager()
        }
        return Static.instance
    }
    
    
    // MARK: Alamofire POST method JSON response call of type Any
    public func executePostURL(url: String, params: Parameters, view: UIView, headers: HTTPHeaders ,completion: @escaping(_ result: DataResponse<Any>)-> Void) {
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).validate().responseJSON { response in
            if(Lib.sharedInstance.isHasConnection()) {
                completion(response)
            }
        }
    }
    
//    public func executePostURL<T: Mappable>(type: T.Type, url: String, params: Parameters, view: UIView, headers: HTTPHeaders ,completion: @escaping(_ result: DataResponse<T>)-> Void) {
//        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).validate().responseJSON { (response: DataResponse<Any>) in
//            if(Lib.sharedInstance.isHasConnection()) {
//                completion(response)
//            }
//        }
//    }
    
    // MARK: Alamofire GET method JSON response call of type Any
    public func executeGetURL(url: String, params: Parameters, view: UIView, completion: @escaping(_ result: DataResponse<Any>)-> Void) {
        Alamofire.request(url, method: .get, parameters: params, encoding: JSONEncoding.default).validate().responseJSON { response in
            if(Lib.sharedInstance.isHasConnection()) {
                completion(response)
            }
        }
    }
    
    // MARK: Alamofire PUT method JSON response call of type Any
    public func executePutURL(url: String, params: Parameters, view: UIView, completion: @escaping(_ result: DataResponse<Any>)-> Void) {
        Alamofire.request(url, method: .put, parameters: params, encoding: JSONEncoding.default).validate().responseJSON { response in
            if(Lib.sharedInstance.isHasConnection()) {
                completion(response)
            }
        }
    }
    
    // MARK: Alamofire GET method MAPPABLE T response call of type Array
    public func executeGetArrayURL<T: Mappable>(type: T.Type, url: String, params: Parameters, view: UIView, completion: @escaping(_ result: DataResponse<[T]>?)-> Void) {
        Alamofire.request(url, method: .get, parameters: params, encoding: JSONEncoding.default).validate().responseArray {
            (response: DataResponse<[T]>) in
            if(Lib.sharedInstance.isHasConnection()) {
                completion(response)
            }
        }
    }
    
    // MARK: Alamofire POST method MAPPABLE T response call of type Array
    public func executePostArrayURL<T: Mappable>(type: T.Type ,url: String, params: Parameters, view: UIView, completion: @escaping(_ result: DataResponse<[T]>?)-> Void) {
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseArray { (response: DataResponse<[T]>) in
            if(Lib.sharedInstance.isHasConnection()) {
                completion(response)
            }
        }
    }
    
    // MARK: Alamofire PUT method MAPPABLE T response call of type Array
    public func executePutArrayURL<T: Mappable>(type: T.Type, url: String, params: Parameters, view: UIView, completion: @escaping(_ result: DataResponse<[T]>?)-> Void) {
        Alamofire.request(url, method: .put, parameters: params, encoding: JSONEncoding.default).validate().responseArray { (response: DataResponse<[T]>) in
            if(Lib.sharedInstance.isHasConnection()) {
                completion(response)
            }
        }
    }
    
    // MARK: Alamofire GET method MAPPABLE response call of type Object
    public func executeGetObjectURL<T: Mappable>(type: T.Type, url: String, params: Parameters, headers: HTTPHeaders, view: UIView, completion: @escaping(_ result: DataResponse<T>?)-> Void) {
        Alamofire.request(url, method: .get, parameters: params, encoding: JSONEncoding.default, headers: headers).validate().responseObject {
            (response: DataResponse<T>) in
            if(Lib.sharedInstance.isHasConnection()) {
                completion(response)
            }
        }
    }
    
    // MARK: Alamofire GET method MAPPABLE response call of type Object
    public func executeGetObjectURLEncoding<T: Mappable>(type: T.Type, url: String, params: Parameters?, headers: HTTPHeaders, view: UIView, completion: @escaping(_ result: DataResponse<T>?)-> Void) {
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).validate().responseObject {
            (response: DataResponse<T>) in
            if(Lib.sharedInstance.isHasConnection()) {
                completion(response)
            }
        }
    }
    
    // MARK: Alamofire POST method MAPPABLE response call of type Object
    public func executePostObjectURL<T: Mappable>(type: T.Type, url: String, params: Parameters, headers: HTTPHeaders ,view: UIView, completion: @escaping(_ result: DataResponse<T>?)-> Void) {
        print(type)
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).validate().responseObject {
            (response: DataResponse<T>) in
            if(Lib.sharedInstance.isHasConnection()) {
                completion(response)
            }
        }
    }
    
    // MARK: Alamofire POST method MAPPABLE with URLEncoding and response call of type Object
    public func executePostUrlEncodingObjectURL<T: Mappable>(type: T.Type, url: String, params: Parameters, headers: HTTPHeaders ,view: UIView, completion: @escaping(_ result: DataResponse<T>?)-> Void) {
        print(type)
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).validate().responseObject {
            (response: DataResponse<T>) in
            if(Lib.sharedInstance.isHasConnection()) {
                completion(response)
            }
        }
    }
    
    // MARK: Alamofire PUT method MAPPABLE response call of type Object
    public func executePutObjectURL<T: Mappable>(type: T.Type, url: String, params: Parameters, view: UIView, completion: @escaping(_ result: DataResponse<T>?)-> Void) {
        Alamofire.request(url, method: .put, parameters: params, encoding: JSONEncoding.default).validate().responseObject {
            (response: DataResponse<T>) in
            if(Lib.sharedInstance.isHasConnection()) {
                completion(response)
            }
        }
    }
}
