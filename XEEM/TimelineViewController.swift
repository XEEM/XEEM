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
    var regionRadius : CLLocationDistance = 0.0;
    var location: CLLocation?
    var listModelShop: [ShopModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init RequestServiceView
        self.viewRequestService.hidden = true
        
        // mapView
        self.loadMapView()
        
        // call API current location
        XEEMService.sharedInstance.getServiceWithCurrentLocation(0, longitde: 0) { (dictionary: AnyObject?, error: NSError?) -> Void in
            let arrData = dictionary as! [NSDictionary]
            self.listModelShop = ShopModel.initShopModelWithArray(arrData)
            print(self.listModelShop)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                for shopModel in self.listModelShop {
                    let shopLocation = CLLocationCoordinate2D(latitude: shopModel.latitude!, longitude: shopModel.longitde!)
                    let shopMarker = MKPointAnnotation()
                    shopMarker.coordinate = shopLocation
                    shopMarker.title = shopModel.name!
                    self.mapView.addAnnotation(shopMarker)
                }
                
            })
        }
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
        
    }

    
    func setInitViewWithTitle(title: String?) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            // find current service with title
            var shopModelCurrent : ShopModel = self.listModelShop[0]
            for shopModel in self.listModelShop {
                if let title = title, name = shopModel.name {
                    print("Title: \(title)")
                    print("Shop name: \(name)")
                    if String(title) == name {
                        shopModelCurrent = shopModel
                        break
                    }
                }
            }
            
            // dummy service view
            self.imageService.image = UIImage(named: "bicycle")
            self.titleServiceLabel.text = shopModelCurrent.name
            self.rateView.notSelectedImage = UIImage(named: "ic_star_unrate_border")
            self.rateView.fullSelectedImage = UIImage(named: "ic_star")
            self.rateView.maxRating = 5;
            self.rateView.rating = round(Float(shopModelCurrent.rating!))
            self.rateView.editable = false;
            
            self.fromLabel.text = "FROM"
            self.priceLabel.text = "$5"
            
            // add observer
            // 3. add action to myView
            let gesture = UITapGestureRecognizer(target: self, action: "onServiceTapView:")
            self.viewRequestService.addGestureRecognizer(gesture)
        }
    }
    
    // MARK: - MapView
    func loadMapView() {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.mapView.delegate = self
            self.mapView.showsUserLocation = true
            self.mapView.mapType = MKMapType.Standard
            
            self.regionRadius = 1000 / 1000.0
            self.locationManager.distanceFilter = self.regionRadius
            self.locationManager.startUpdatingLocation()
            self.locationManager.delegate = self
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.requestAlwaysAuthorization()
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        self.location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: self.location!.coordinate.latitude, longitude: self.location!.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
        
        self.mapView.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Errors: " + error.localizedDescription)
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation, animated: true)
        if let annotation = view.annotation, title = annotation.title {
            if title != self.mapView.userLocation.title {
                self.viewRequestService.hidden = false
                if let title = title {
                    self.setInitViewWithTitle(title)
                }

            }
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let kPinAnnotationIdentifier :String = "PinIdentifier"
        if annotation.isEqual(self.mapView.userLocation) {
            print("aaaa")
            return nil
        }
        if self.listModelShop.count == 0 {
            return nil
        }
        let myAnnotation = self.mapView.dequeueReusableAnnotationViewWithIdentifier(kPinAnnotationIdentifier)
        myAnnotation?.image = UIImage(named: "ic_add_image")
        myAnnotation?.annotation = annotation

        return myAnnotation
    }
    
    
    @IBOutlet var onTapWKMapView: UITapGestureRecognizer!
    
    @IBAction func onTapWKMapView(sender: UITapGestureRecognizer) {
        self.viewRequestService.hidden = true
    }
    
    // MARK: - Emergency
    
    @IBOutlet weak var btnEmergency: UIButton!
    
    @IBAction func onEmergencyTapped(sender: UIButton) {
        // TO-DO
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
