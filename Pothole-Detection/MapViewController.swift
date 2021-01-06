//
//  MapViewController.swift
//  Pothole-Detection
//
//  Created by Odyssey Wilson on 11/17/20.
//

import Foundation
import UIKit
import MapKit
//class LocationManager: CLLocationManager {
    
//}

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager:CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("map loaded")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("map appeared")
        //Request location from user- currently set to be able to use location in background
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone //Location will constantly update
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //CLLocation objects passed in store longitude latitude coordinates
        guard let first = locations.first else { //If there not at least one element, return
            print("Failed to get user location")
            return
        }
        print("uuuhhhh hello?")
        let newLocation = CLLocation(latitude: first.coordinate.latitude, longitude: first.coordinate.longitude)
        let radius:CLLocationDistance = 1000
        let region = MKCoordinateRegion(center: newLocation.coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        mapView.setRegion(region, animated: true)
        
        
        

    }
    
    func putPinOnMap(){
        
    }
}
