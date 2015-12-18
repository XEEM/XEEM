//
//  XEEMService.swift
//  XEEM
//
//  Created by Giao Tuan on 12/17/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import Foundation
import Alamofire

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
        Alamofire.request(.POST, "http://www.xeem.somee.com/api/auth/authenticate?email=hatu87@gmail.com&password=123").responseJSON { (response ) -> Void in
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

    
}