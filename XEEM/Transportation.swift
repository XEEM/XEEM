//
//  Transportation.swift
//  XEEM
//
//  Created by Giao Tuan on 12/12/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import Foundation
import RealmSwift

enum TransportationType: String  {
    case Bike = "B"
    case Car = "C"
    case Scooter = "S"
    case Motorbike = "M"
}

class Transportation : Object {
    dynamic var id : String!
    dynamic var name : String!
    dynamic var type: String!
    dynamic var imageUrls: String!
    //var requests: [Request]!
    dynamic var isDefault = false
    
    convenience required init(dictionary : NSDictionary) {
        self.init()
        id = String(dictionary["Id"])
        name = dictionary["Name"] as? String
        type = dictionary["Type"] as! String
        isDefault = false
        imageUrls = (dictionary["ImageUrls"] as? [String])![0]
        
        //requests = Request.InitWithArray(dictionary["Requests"] as! [NSDictionary])
    }

    class func TransWithArray(array: [NSDictionary]) -> List<Transportation> {
        let trans = List<Transportation>()
        for dict in array {
            trans.append(Transportation(dictionary: dict))
        }
        return trans
    }
}
