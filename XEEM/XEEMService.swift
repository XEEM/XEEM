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
    
    func getUserProfile(currenUser: User!, completion: (user: User?, error: NSError?) -> ()) {
        Alamofire.request(.GET,"http://www.xeem.somee.com/api/user/", parameters: ["api_token": "0"]).responseJSON { (response) -> Void in
                let jsonData = response.result.value
                let error = response.result.error
                if let error = error {
                    completion(user: nil,error: error)
                } else {
                    print(jsonData)
                    let user = User(dictionary: jsonData as! NSDictionary)
                    completion(user: user,error: nil)
                   
                }

        }
    }

    
}