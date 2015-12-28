//
//  HomeViewController.swift
//  XEEM
//
//  Created by Le Thanh Tan on 12/28/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SlideMenuControllerSwift


class HomeViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var regionRadius : CLLocationDistance = 0.0
    let locationManager = CLLocationManager()
    var location: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.barTintColor = UIColor.MKColor.AppMainColor
        navigationController!.navigationBar.tintColor = UIColor.MKColor.AppMainColor
        
        SlideMenuOptions.panFromBezel = true
        self.loadMapView()
    }

    private func loadMapView() {
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleSideMenu(sender: UIBarButtonItem) {
        self.slideMenuController()?.toggleLeft()
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

// MARK: - MKMapViewDelegate
extension HomeViewController: MKMapViewDelegate {
    
}

// MARK: - CLLocationManagerDelegate
extension HomeViewController: CLLocationManagerDelegate {
    // On location updated
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

}
