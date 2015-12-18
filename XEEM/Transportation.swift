//
//  Transportation.swift
//  XEEM
//
//  Created by Giao Tuan on 12/12/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import Foundation

class Transportation: NSObject {
    var type : String!
    var id : String!
    var name : String!
    var dictionary: NSDictionary
    
    init(dictionary : NSDictionary) {
        self.dictionary = dictionary
        id = dictionary["Id"] as? String
        name = dictionary["Name"] as? String
        type = dictionary["Type"] as? String
    }
    
    class func TransWithArray(array: [NSDictionary]) -> [Transportation] {
        var trans = [Transportation]()
        for dict in array {
            trans.append(Transportation(dictionary: dict))
        }
        return trans
    }
}
