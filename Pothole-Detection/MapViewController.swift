//
//  MapViewController.swift
//  Pothole-Detection
//
//  Created by Odyssey Wilson on 11/17/20.
//

import Foundation
import UIKit
import MapKit
import CoreMotion


//class LocationManager: CLLocationManager {
    
//}

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager:CLLocationManager = CLLocationManager()
    var x_arr = Array<Double>(repeating: 0, count: 20)
    var y_arr = Array<Double>(repeating: 0, count: 20)
    var z_arr = Array<Double>(repeating: 0, count: 20)
    
    
    var motion = CMMotionManager()
    var onMapView = false;

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
        myAccelerometer()
        

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("Map is gone")
        stopMyAccelerometer()
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
    
        

        func myAccelerometer() {
            print("Start Accelerometer")
            motion.accelerometerUpdateInterval = 0.5
            motion.startAccelerometerUpdates(to: OperationQueue.current!) {
                (data, error) in
                print(data as Any)
                if let trueData =  data {
                    self.x_arr.removeFirst()
                    self.y_arr.removeFirst()
                    self.z_arr.removeFirst()
                    self.view.reloadInputViews()
                    let x = trueData.acceleration.x
                    let y = trueData.acceleration.y
                    let z = trueData.acceleration.z
                    self.x_arr.append(x)
                    self.y_arr.append(y)
                    self.z_arr.append(z)
                    
                    if (abs(self.x_arr[self.x_arr.count - 1] - self.x_arr[self.x_arr.count - 2]) > abs(0.5)) && self.x_arr.count > 1{
                        print("Pothole detected")

                    }
                    if (abs(self.y_arr[self.y_arr.count - 1] - self.y_arr[self.y_arr.count - 2]) > abs(0.5)) && self.y_arr.count > 1{
                        print("Pothole detected")

                    }
                }
            }
            
            return
        }
    func stopMyAccelerometer() {
        motion.stopAccelerometerUpdates()
    }

    
    func putPinOnMap(){
        
    }
}
