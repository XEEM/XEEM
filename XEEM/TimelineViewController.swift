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
import SlideMenuControllerSwift

class TimelineViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var viewRequestService: UIView!
    @IBOutlet weak var imageService: UIImageView!
    @IBOutlet weak var titleServiceLabel: UILabel!
    @IBOutlet weak var rateView: FloatRatingView!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    var currentUser : User!
    var regionRadius : CLLocationDistance = 0.0;
    var location: CLLocation?
    var listModelShop: [ShopModel] = []
    var selectedShopModel: ShopModel?
    var filterList : [Int]!
    
    // contraint
    @IBOutlet weak var bottomViewRequestServiceConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor.MKColor.AppMainColor
        SlideMenuOptions.panFromBezel = true
        (self.slideMenuController()?.rightViewController as! RightViewController).delegate = self
        // init RequestServiceView
        self.bottomViewRequestServiceConstraint.constant = -100
        
        //
        let defaults = NSUserDefaults.standardUserDefaults()
        filterList = defaults.objectForKey("FILTER_KEY") as? [Int] ?? [0,1,2,3,4]
        
        
        // mapView
        self.loadMapView()
    }
    
    // Request service shops with filter input
    func requestData(filter : [Int]!) -> () {
        XEEMService.sharedInstance.getServiceWithCurrentLocation(0, longitde: 0, filter: filter) { (dictionary: AnyObject?, error: NSError?) -> Void in
            let arrData = dictionary as! [NSDictionary]
            self.listModelShop = ShopModel.initShopModelWithArray(arrData,currentLocation: self.location)
            self.mapView.removeAnnotations(self.mapView.annotations)
            // draw markers
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                for shopModel in self.listModelShop {
                    let shopLocation = CLLocationCoordinate2D(latitude: shopModel.latitude!, longitude: shopModel.longitde!)
                    let shopMarker = CustomPointAnnotation()
                    shopMarker.coordinate = shopLocation
                    
                    shopMarker.shopModel = shopModel
                    switch shopModel.type! {
                        case "B":
                            shopMarker.imageName = "ic_bike"
                            break
                        case "C":
                            shopMarker.imageName = "ic_car"
                            break
                        case "S":
                            shopMarker.imageName = "ic_vespa"
                            break
                        case "G":
                            shopMarker.imageName = "ic_oil"
                            break
                        case "M":
                            shopMarker.imageName = "ic_motorbike"
                            break
                        default:
                            shopMarker.imageName = "ic_bike"
                            break
                    }
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
        repairVC.imageService = self.imageService
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
            //TODO
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.bottomViewRequestServiceConstraint.constant = 0
                self.viewRequestService.layoutIfNeeded()
                }, completion: nil)
            
            self.selectedShopModel = shopModel
            // dummy service view
            self.imageService.image = UIImage(named: "bicycle")
            
            switch shopModel!.type! {
            case "B":
                self.imageService.image = UIImage(named: "ic_bike")
                break
            case "C":
                self.imageService.image = UIImage(named: "ic_car")
                break
            case "S":
                self.imageService.image = UIImage(named: "ic_vespa")
                break
            case "G":
                self.imageService.image = UIImage(named: "ic_oil")
                break
            case "M":
                self.imageService.image = UIImage(named: "ic_motorbike")
                break
            default:
                self.imageService.image = UIImage(named: "ic_bike")
                break
            }

            self.titleServiceLabel.text = shopModel!.name
            print(shopModel?.rating!)
            let distance = Double(round(1000*((shopModel?.distance)! / 1000))/1000)
            self.rateView.rating = (shopModel?.rating!)!
            self.distanceLabel.text = "\(String(distance)) KM"
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
    
    // On location updated
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        self.location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: self.location!.coordinate.latitude, longitude: self.location!.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
        
        self.mapView.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
        
        requestData(filterList)
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
        let pin: UIImage = UIImage(named: cpa.imageName)!
        annotationView = FloatingAnnotationView(annotation: annotation, reuseIdentifier: "identifier", image: pin)
        annotationView!.canShowCallout = false
        return annotationView
    }
    
    
    @IBOutlet var onTapWKMapView: UITapGestureRecognizer!
    
    @IBAction func onTapWKMapView(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.bottomViewRequestServiceConstraint.constant = -100
            self.viewRequestService.layoutIfNeeded()
            }, completion: nil)

    }
    
    // MARK: - Emergency
    
    @IBOutlet weak var btnEmergency: UIButton!
    
    @IBAction func onEmergencyTapped(sender: UIButton) {
        // TO-DO
        let myPopupViewController:EmergencyViewController = EmergencyViewController(nibName:"EmergencyView", bundle: nil)
        myPopupViewController.delegate = self
        self.presentpopupViewController(myPopupViewController, animationType: .Fade, completion: { () -> Void in })

    }
    
    // MARK: - MyLocation
    @IBAction func onMyLocationUpdate(sender: UIButton) {
        self.locationManager.startUpdatingLocation()
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
    }
}

extension TimelineViewController: RightViewControllerDelegate,EmergencyDelegate {
    func rightViewController(rightViewController : RightViewController, filterChange listFilter: [Int]!) {
        print("FILTER DELEGATE on home")
        requestData(listFilter)
        // fetch data again
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.bottomViewRequestServiceConstraint.constant = -100
            self.viewRequestService.layoutIfNeeded()
            }, completion: nil)
    }
    func emergency(emergencyView: EmergencyViewController, didCancelTap onCancelTap: UIButton) {
        self.navigationController?.dismissPopupViewController(.Fade)
    }
    
    func emergency(emergencyView: EmergencyViewController, didHelpTap onHelp: UIButton, whichSelection selection: Int) {
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let listReviewVC =  storyboard.instantiateViewControllerWithIdentifier("RequestLoadingViewController") as! RequestLoadingViewController
        self.navigationController?.presentpopupViewController(listReviewVC, animationType: .RightLeft, completion: { () -> Void in })

    }
}
