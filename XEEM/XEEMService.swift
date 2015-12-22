//
//  XEEMService.swift
//  XEEM
//
//  Created by Giao Tuan on 12/17/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import Foundation
import Alamofire

enum METHOD {
    case POST
    case GET
    case PUT
}

typealias ServiceResponse = (AnyObject?, NSError?) -> Void

class XEEMService {
    
    class var sharedInstance : XEEMService {
        struct Static {
            static let instance = XEEMService()
        }
        return Static.instance
    }
    
    func getUserProfile(token: String!, completion: (user: User?, error: NSError?) -> ()) {
        Alamofire.request(.GET,"http://www.xeem.somee.com/api/user/", parameters: ["api_token": token]).responseJSON { (response) -> Void in
                let jsonData = response.result.value
                let error = response.result.error
                if let error = error {
                    print("Get USER PROFILE error",error)
                    completion(user: nil,error: error)
                } else {
                    print(jsonData)
                    let user = User(dictionary: jsonData as! NSDictionary)
                    completion(user: user,error: nil)
                   
                }
        }
    }
    func login(username: String!, passwd: String!, completion: (token: String?, error: NSError?) -> ()) {
        Alamofire.request(.POST, "http://www.xeem.somee.com/api/auth/authenticate?email=ken.hoang87:&password=123").responseJSON { (response ) -> Void in
            let token = response.result.value
            let error = response.result.error
            if let token = token {
                print("LOGIN SUCCESSFULL",token)
                completion(token: token as? String,error: nil)
            } else {
                print("LOGIN ERROR",error)
                completion(token: nil,error: error)
            }
        }
    }
    
    
    func getServiceWithCurrentLocation (latitude: Double!, longitde: Double!, onCompletion: ServiceResponse) {
        let url = "http://www.xeem.somee.com/api/shops?api_token=0"
        self.callAPIWithURL(url, method: METHOD.GET, header: nil, params: nil, onCompletion: onCompletion)
    }
    
    
    func callAPIWithURL(url: String, method:(METHOD), header:(NSDictionary?), params:(NSDictionary?), onCompletion:ServiceResponse) {
        self.internalCallApiWithURL(url, method: method, header: header, params: params, onCompletion: onCompletion)
    }
    
    func internalCallApiWithURL(url: String, method: (METHOD), header:NSDictionary?, params:NSDictionary?, onCompletion:ServiceResponse) {
        if method == METHOD.GET {
            let headerAs = header as? [String:String]
            let paramsAs = params as? [String: AnyObject]
            Alamofire.request(.GET, url, parameters: paramsAs, encoding: .JSON, headers: headerAs).responseData({ (response: Response<NSData, NSError>) -> Void in
                
                guard response.result.error == nil else {
                    onCompletion(response.result.value!, response.result.error!)
                    return
                }
                
                let dic = try! NSJSONSerialization.JSONObjectWithData(response.result.value!, options: .AllowFragments)
              //  print(dic)
                
                let error = response.result.error
                onCompletion(dic, error)
                
            })
        } else if (method == METHOD.POST) {
            let headerAs = header as? [String:String]
            let paramsAs = params as? [String: AnyObject]
            Alamofire.request(.POST, url, parameters: paramsAs, encoding: .JSON, headers: headerAs).responseData({ (response: Response<NSData, NSError>) -> Void in
                
                guard response.result.error == nil else {
                    onCompletion(response.result.value!, response.result.error!)
                    return
                }
                
                let dic = try! NSJSONSerialization.JSONObjectWithData(response.result.value!, options: .AllowFragments)
               // print(dic)
                
                let error = response.result.error
                onCompletion(dic, error)
                
            })
            
        }
    }


    
}