//
//  ReceivedServiceViewController.swift
//  XEEM
//
//  Created by USER on 12/21/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit
import FontAwesome_swift
import MapKit

class ReceivedServiceViewController: UIViewController {

    @IBOutlet weak var requestAccepetedTitleLabel: UILabel!
    
    @IBOutlet weak var imageRepairService: UIImageView!
    
    @IBOutlet weak var repairServiceLabel: UILabel!
    
    @IBOutlet weak var ratingView: FloatRatingView!
    
    @IBOutlet weak var receivedServiceBtn: UIButton!
    
    @IBOutlet weak var etaLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    var selectedShop : ShopModel!
    var quotationIndex : Int!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        receivedServiceBtn.backgroundColor = UIColor.MKColor.Orange
        receivedServiceBtn.setTitleColor(UIColor.MKColor.WhiteColor, forState: UIControlState.Normal)
        ratingView.editable = false
        ratingView.rating = selectedShop.rating!
        repairServiceLabel.text = selectedShop.name
        //distanceLabel.text = UIUtils.convertDistance(selectedShop.distance!)
        
        let request: MKDirectionsRequest = MKDirectionsRequest()
        request.source = MKMapItem.mapItemForCurrentLocation()
        //let placemarkSrc = MKPlacemark(coordinate: currentLocation!.coordinate, addressDictionary: nil)
        let placemarkDes = MKPlacemark(coordinate: (selectedShop.location!.coordinate), addressDictionary: nil)
        request.destination = MKMapItem(placemark: placemarkDes)
        request.transportType = .Automobile
        request.requestsAlternateRoutes = false
        let directions: MKDirections = MKDirections(request: request)
        var eta = "--:--:--"
        directions.calculateETAWithCompletionHandler { (response : MKETAResponse?, error : NSError?) -> Void in
            if let response = response {
                print(response.expectedTravelTime)
                eta = UIUtils.stringFromTimeInterval(response.expectedTravelTime)
                self.etaLabel.text = eta
                //self.eta = UIUtils.stringFromTimeInterval(response.expectedTravelTime)
                //  print(response.expectedTravelTime)
                // print(self.eta)
                //route.distance  = The distance
                //route.expectedTravelTime = The ETA
            } else {
                
            }
        }

        
        etaLabel.text = selectedShop.eta

//        priceLabel.text = "About $\(selectedShop.quotes![quotationIndex].price as! Int) with your problem"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReceviedServiceTap(sender: UIButton) {

    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let nextViewControler = segue.destinationViewController as! FinishServiceViewController
        //let nextViewControler = navigationControler.topViewController
        if nextViewControler is FinishServiceViewController {
            (nextViewControler as! FinishServiceViewController).selectedShop   = self.selectedShop
        } 
    }


}

