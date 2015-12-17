//
//  TimelineViewController.swift
//  Timeline
//
//  Created by Hossam Ghareeb on 8/14/15.
//  Copyright © 2015 Hossam Ghareeb. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TimelineViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var viewRequestService: UIView!
    @IBOutlet weak var imageService: UIImageView!
    @IBOutlet weak var titleServiceLabel: UILabel!
    @IBOutlet weak var rateView: RateView!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    var currentUser : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfile()
        self.swiftySideMenu?.enableRightSwipeGesture = false
        
        // dummy service view
        self.imageService.image = UIImage(named: "bicycle")
        self.titleServiceLabel.text = "Repair Services"
        self.rateView.notSelectedImage = UIImage(named: "ic_star_unrate_border")
        self.rateView.fullSelectedImage = UIImage(named: "ic_star")
        self.rateView.maxRating = 5;        
        self.rateView.rating = 3
        self.rateView.editable = false;

        self.fromLabel.text = "FROM"
        self.priceLabel.text = "$5"
        
        // add observer
        // 3. add action to myView
        let gesture = UITapGestureRecognizer(target: self, action: "onServiceTapView:")
        self.viewRequestService.addGestureRecognizer(gesture)
        
        
//        mapView.delegate = self
        // set initial location in Honolulu
//        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
//        let regionRadius: CLLocationDistance = 1000
//        func centerMapOnLocation(location: CLLocation) {
//            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
//                regionRadius * 2.0, regionRadius * 2.0)
//            mapView.setRegion(coordinateRegion, animated: true)
//        }
        
//        centerMapOnLocation(initialLocation)
        
        // Do any additional setup after loading the view.
    }

    func onServiceTapView(sender:UITapGestureRecognizer){
        // do other task
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let repairVC =  storyboard.instantiateViewControllerWithIdentifier("RepairServiceViewController") as! RepairServiceViewController
        self.navigationController?.pushViewController(repairVC, animated: true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func toggleSideMenu(sender: AnyObject) {
        self.swiftySideMenu?.toggleSideMenu()
        
    }
    
    func getProfile() {
        XEEMService.sharedInstance.getUserProfile(nil) { (user, error) -> () in
            print(user)
            if let user = user {
                print("saved data")
                User.currentUser = user
            }
        }
    }
    
    // MARK - ViewService Click
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
