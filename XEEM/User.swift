//
//  User.swift
//  XEEM
//
//  Created by Giao Tuan on 12/17/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

var _currentUser: User?
let USER_KEY = "CURRENT_USER"


class User: Object {
    dynamic var id: String?
    dynamic var fullName: String?
    dynamic var username: String?
    dynamic var password: String?
    dynamic var token: String?
    dynamic var email: String?
    dynamic var address: String?
    dynamic var phone: String?
    var transList = List<Transportation>()
    dynamic var avatarURL: String?
    dynamic var defaultVehicles : Transportation?
   

    required convenience init(dictionary : NSDictionary?) {
        self.init()
        if let dictionary = dictionary {
            fullName = dictionary["name"] as? String
            id = dictionary["Id"] as? String
            fullName = dictionary["Name"] as? String
            email = dictionary["Email"] as? String
            password = dictionary["Password"] as? String
            address = dictionary["Address"] as? String
            phone = dictionary["Phone"] as? String
            avatarURL = dictionary["AvatarUrl"] as? String ?? ""
            transList = Transportation.TransWithArray(dictionary["Transporations"] as! [NSDictionary])
            defaultVehicles = transList[0] as Transportation?
            transList[0].isDefault = true
        }
    }

    
    // Save curent user
    class var currentUser: User? {
        get {
        if _currentUser == nil {
//                let data = NSUserDefaults.standardUserDefaults().objectForKey(USER_KEY)
//                if data != nil {
//                    do {
//                        let dict = try NSJSONSerialization.JSONObjectWithData(data! as! NSData, options: [])
//                        _currentUser = User(dictionary: dict as! NSDictionary)
//                    } catch {
//                        print(error)
//                        return _currentUser
//                }
//            }
        let realm = try! Realm()
        _currentUser = realm.objects(User).first as User!
        
        }
        return _currentUser
        }
        
        set (user) {
            _currentUser = user
            if _currentUser != nil {
                // save to realm
                let realm = try! Realm()
                 try! realm.write {
                     realm.deleteAll()
                    realm.add(_currentUser!)
                    print("Save success")
                }
//                // save to NSDefault
//                do {
//                    let data = try NSJSONSerialization.dataWithJSONObject(nil, options: [])
//                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: USER_KEY)
//                } catch let error as NSError {
//                    print(error)
//                    NSUserDefaults.standardUserDefaults().setObject(nil, forKey: USER_KEY)
//                }
            } else {
                let realm = try! Realm()
                try! realm.write {
                    realm.deleteAll()
                }
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

}
