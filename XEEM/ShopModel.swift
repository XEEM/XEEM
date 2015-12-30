//
//  ShopModel.swift
//  XEEM
//
//  Created by Le Thanh Tan on 12/19/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ShopModel: NSObject {
    
    var id: String?
    var name: String?
    var address: String?
    var phone: String?
    var isAvailable: Bool
    var latitude: Double?
    var longitde: Double?
    var avatarURL: String!
    var createdDate: String?
    var type: String?
    var owner: User?
    var reviews: [ReviewModel]?
    var quotes: [Quotes]?
    var rating: Float?
    var location : CLLocation?
    var distance : CLLocationDistance?
    var eta : String?
    
    override init() {
        self.isAvailable = true
        super.init()

    }
    
    init(dictionary: NSDictionary,currentLocation: CLLocation?) {
        self.id = String(dictionary.objectForKey("Id"))
        self.name = dictionary.objectForKey("Name") as? String
        self.address = dictionary.objectForKey("Address") as? String
        self.phone = dictionary.objectForKey("Phone") as? String
        self.isAvailable = (dictionary.objectForKey("IsAvailable") as? Bool)!
        self.latitude = Double((dictionary.objectForKey("Latitude") as? String)!)
        self.longitde = Double((dictionary.objectForKey("Longitude") as? String)!)
        self.location = CLLocation(latitude: self.latitude!, longitude: self.longitde!)
        self.distance = currentLocation?.distanceFromLocation(self.location!)
        
        self.avatarURL = dictionary.objectForKey("AvatarUrl") as? String ?? ""
        self.createdDate = dictionary.objectForKey("CreatedDate") as? String
        self.type = dictionary.objectForKey("Type") as? String
        self.owner = User.init(dictionary: dictionary.objectForKey("Owner") as? NSDictionary)
        self.reviews = ReviewModel.initWithArray(dictionary.objectForKey("Reviews") as! [NSDictionary])
        self.quotes = Quotes.initWithArray(dictionary.objectForKey("Quotes") as! [NSDictionary])
        self.rating = dictionary.objectForKey("Rating") as? Float

    }
    
    class func initShopModelWithArray(array: [NSDictionary], currentLocation: CLLocation?) -> [ShopModel] {
        var trans = [ShopModel]()
        for dict in array {
            trans.append(ShopModel(dictionary: dict,currentLocation: currentLocation))
        }
        return trans
    }
    
    
}


