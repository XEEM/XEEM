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
    var selectedShopModel: ShopModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor.MKColor.AppMainColor
        
        // init RequestServiceView
        self.viewRequestService.hidden = true


        
        // mapView
        self.loadMapView()
        
        // call API current location
        XEEMService.sharedInstance.getServiceWithCurrentLocation(0, longitde: 0) { (dictionary: AnyObject?, error: NSError?) -> Void in
            let arrData = dictionary as! [NSDictionary]
            self.listModelShop = ShopModel.initShopModelWithArray(arrData)

            // draw markers
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                for shopModel in self.listModelShop {
                    let shopLocation = CLLocationCoordinate2D(latitude: shopModel.latitude!, longitude: shopModel.longitde!)
                    let shopMarker = CustomPointAnnotation()
                    shopMarker.coordinate = shopLocation
                    shopMarker.imageName = "ic_bike"
                    shopMarker.shopModel = shopModel
                    //shopMarker.title = shopModel.name!
                    self.mapView.addAnnotation(shopMarker)
                }       
            })
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func onServiceTapView(sender:UITapGestureRecognizer){
        // do other task
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let repairVC =  storyboard.instantiateViewControllerWithIdentifier("RepairServiceViewController") as! RepairServiceViewController
        repairVC.shopModel = self.selectedShopModel
        self.navigationController?.pushViewController(repairVC, animated: true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toogleRightButton(sender: UIBarButtonItem) {
         self.slideMenuController()?.toggleRight()
    }

    @IBAction func toggleSideMenu(sender: AnyObject) {
        self.slideMenuController()?.toggleLeft()
    }

    
    func setInitViewWithTitle(shopModel: ShopModel?) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            // find current service with title
            self.viewRequestService.hidden = false
            self.selectedShopModel = shopModel
            // dummy service view
            self.imageService.image = UIImage(named: "bicycle")
            self.titleServiceLabel.text = shopModel!.name
            self.rateView.notSelectedImage = UIImage(named: "ic_star_unrate_border")
            self.rateView.fullSelectedImage = UIImage(named: "ic_star")
            self.rateView.maxRating = 5;
            self.rateView.rating = round(Float(shopModel!.rating!))
            self.rateView.editable = false;
            
            self.fromLabel.text = ""
            self.priceLabel.text = "$"
            
            
            
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
        print("tapannontation")
        if view.annotation!.isEqual(self.mapView.userLocation) {
            return
        }
        let cpa = view.annotation as! CustomPointAnnotation
        print(cpa.shopModel)
        print(cpa.imageName)
        mapView.deselectAnnotation(view.annotation, animated: true)
        self.setInitViewWithTitle(cpa.shopModel)
    }
    
    // Custom annontationView
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isEqual(self.mapView.userLocation) {
            return nil
        }
        let cpa = annotation as! CustomPointAnnotation
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("identifier") as? FloatingAnnotationView
        if annotationView == nil {
            let pin: UIImage = UIImage(named: cpa.imageName)!
            annotationView = FloatingAnnotationView(annotation: annotation, reuseIdentifier: "identifier", image: pin)
            annotationView!.canShowCallout = false
        } else {
            annotationView!.annotation = annotation
            annotationView!.canShowCallout = true
        }
        
        return annotationView
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
    
    class CustomPointAnnotation: MKPointAnnotation {
        var imageName: String!
        var shopModel: ShopModel?
    }
    
    class FloatingAnnotationView: MKAnnotationView {
        var imageView: UIImageView!
        
        convenience init(annotation: MKAnnotation, reuseIdentifier: String, image: UIImage) {
            self.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
            //self.backgroundColor = UIColor.redColor()
            let frame: CGRect = CGRectMake(0, 0, 40, 40)
            self.frame = frame
            //self.centerOffset = CGPointMake(0, -CGRectGetHeight(frame) / 2)
            let imageView: UIImageView = UIImageView(image: image)
            imageView.frame = frame
            self.imageView = imageView
            self.addSubview(imageView)
        }
    }}
