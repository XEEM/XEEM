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
        Alamofire.request(.GET,"http://xeem.apphb.com/api/user/", parameters: ["api_token": token]).responseJSON { (response) -> Void in
                let jsonData = response.result.value
                let error = response.result.error
                if let error = error {
                    print("Get USER PROFILE error",error)
                    completion(user: nil,error: error)
                } else {
                    print(jsonData)
                    let user = User(dictionary: jsonData as? NSDictionary)
                    completion(user: user,error: nil)
                   
                }
        }
    }
    func login(username: String!, passwd: String!, completion: (token: String?, error: NSError?) -> ()) {
        Alamofire.request(.POST, "http://xeem.apphb.com/api/auth/authenticate?email=hatu87@gmail.com&password=123").responseJSON { (response ) -> Void in
            
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
    
    func acceptRequest(token: String, requestToken: String, completion: (request: Request?, error: NSError?) -> Void){
        //let url = "http://xeem.apphb.com/api/requests/\(requestToken)/accept"
        let url = "http://xeem.apphb.com/api/requests/\(requestToken)/accept"
        Alamofire.request(.POST, url, parameters: ["api_token": token]).responseJSON { (response) -> Void in
            let jsonData = response.result.value
            let error = response.result.error
            if let error = error {
                print("Get Shop error",error)
                completion(request: nil, error: error)
            } else {
                print(jsonData)
                let request = Request(dictionary: jsonData as! NSDictionary)
                completion(request: request, error: nil)
                
            }
        }
    }
    
    func cancelRequest(token: String, requestToken: String, completion: (request: Request?, error: NSError?) -> Void){
        //let url = "http://xeem.apphb.com/api/requests/\(requestToken)/accept"
        let url = "http://xeem.apphb.com/api/requests/\(requestToken)/cancel"
        Alamofire.request(.POST, url, parameters: ["api_token": token]).responseJSON { (response) -> Void in
            let jsonData = response.result.value
            let error = response.result.error
            if let error = error {
                print("Get Shop error",error)
                completion(request: nil, error: error)
            } else {
                print(jsonData)
                let request = Request(dictionary: jsonData as! NSDictionary)
                completion(request: request, error: nil)
                
            }
        }
    }
    
    func getRequest(apiToken: String!, requestToken: String!, completion: (request: Request?, error: NSError?) -> ()) {
        let url = "http://xeem.apphb.com/api/requests/\(requestToken)"
        let params = [
            "api_token": apiToken
        ]
        
        Alamofire.request(.GET, url, parameters: params).responseJSON { (response) -> Void in
            let jsonData = response.result.value
            let error = response.result.error
            if let error = error {
                print("Get Shop error",error)
                completion(request: nil, error: error)
            } else {
                print(jsonData)
                let request = Request(dictionary: jsonData as! NSDictionary)
                completion(request: request, error: nil)
                
            }
        }
    }

    func sendRequest(apiToken: String!, shopId: String!, transportationId: String!, latitude: Double!, longitude: Double!, description: String!, completion: (token: String?, error: NSError?) -> ()) {
        let url = "http://xeem.apphb.com/api/requests"
        let params = [
            "api_token": apiToken,
            "shop_id": shopId,
            "transportation_id": transportationId,
            "latitude": latitude,
            "longitude": longitude,
            "description": "flat tire"
        ]
        
        Alamofire.request(.PUT, url, parameters: params as! [String : AnyObject]).responseJSON { (response) -> Void in
            let jsonData = response.result.value
            let error = response.result.error
            if let error = error {
                print("Get Shop error",error)
                completion(token: nil, error: error)
            } else {
                print(jsonData)
                let token = jsonData as! String
                //let request = Request(dictionary: jsonData as! NSDictionary)
                completion(token: token, error: nil)
                
            }
        }
    }
    
    func getServiceWithCurrentLocation (latitude: Double!, longitde: Double!, filter : [Int]!, onCompletion: ServiceResponse) {
        var filterString = ""
        for intValue in filter {
            switch intValue {
            case 0:
                filterString.append("C" as Character)
                break
            case 1:
                filterString.append("-" as Character)
                filterString.append("B" as Character)
                break
            case 2:
                filterString.append("-" as Character)
                filterString.append("M" as Character)
                break
            case 3:
                filterString.append("-" as Character)
                filterString.append("S" as Character)
                break
            case 4:
                filterString.append("-" as Character)
                filterString.append("G" as Character)
                break
            default:
                break
                
            }
        }
        let url = "http://xeem.apphb.com/api/shops?api_token=0&filters=" + filterString
        print(url)
        self.callAPIWithURL(url, method: METHOD.GET, header: nil, params: nil, onCompletion: onCompletion)
    }
    
    func registerUser(email: String?, phone: String?, password: String?, onCompletion: ServiceResponse) {
        let url = "http://xeem.apphb.com/api/users?email=\(email!)&password=\(password!)&phone=\(phone!)&birthday=1987-01-25"
        print(url)
        self.callAPIWithURL(url, method: METHOD.PUT, header: nil, params: nil, onCompletion: onCompletion)
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
        } else if (method == METHOD.PUT) {
            let headerAs = header as? [String:String]
            let paramsAs = params as? [String: AnyObject]
            Alamofire.request(.PUT, url, parameters: paramsAs, encoding: .JSON, headers: headerAs).responseData({ (response: Response<NSData, NSError>) -> Void in
                
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