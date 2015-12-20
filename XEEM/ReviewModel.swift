//
//  ReviewModel.swift
//  XEEM
//
//  Created by Le Thanh Tan on 12/19/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class ReviewModel: NSObject {

    var rating: Int?
    var descriptions: String?
    var reviewer: User?
    
    init(dictionary: NSDictionary) {
        self.rating = dictionary.objectForKey("Rating") as? Int
        self.descriptions = dictionary.objectForKey("Description") as? String
        self.reviewer = User.init(dictionary: dictionary.objectForKey("Reviewer") as! NSDictionary)
    }
    
    class func initWithArray(array: [NSDictionary]) -> [ReviewModel] {
        var arrReviewModel = [ReviewModel]()
        for dic in array {
            arrReviewModel.append(ReviewModel.init(dictionary: dic))
        }        
        return arrReviewModel
    }
        

}
