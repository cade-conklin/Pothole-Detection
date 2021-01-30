//
//  MapViewController.swift
//  Pothole-Detection
//
//  Created by Odyssey Wilson on 11/17/20.
//
import FirebaseDatabase
import Foundation
import UIKit
import MapKit
import CoreMotion

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    private let database = Database.database().reference()
    
    let locationManager:CLLocationManager = CLLocationManager()
    let userNotificationCenter = UNUserNotificationCenter.current()

    var x_arr = Array<Double>(repeating: 0, count: 20)
    var y_arr = Array<Double>(repeating: 0, count: 20)
    var z_arr = Array<Double>(repeating: 0, count: 20)
    
    
    var motion = CMMotionManager()
    var onMapView = false;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("map loaded")
        self.requestNotificationAuthorization()
        self.sendNotification(lon: 0.0, lat: 0.0)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("map appeared")
        startLocationCollection()
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
        let newLocation = CLLocation(latitude: first.coordinate.latitude, longitude: first.coordinate.longitude)
        let radius:CLLocationDistance = 1000
        let region = MKCoordinateRegion(center: newLocation.coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        mapView.setRegion(region, animated: true)
        
    }
    
    func startLocationCollection(){
        //Request location from user- currently set to be able to use location in background
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone //Location will constantly update
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        
        //set the map view coordinates
        guard let coordinate = locationManager.location?.coordinate else {return}
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 400, longitudinalMeters: 400)
        mapView.setRegion(coordinateRegion, animated: true)
        
        mapView.showsUserLocation = true
        
        
    }
    
    func requestNotificationAuthorization() {
        // Code here
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
                if let error = error {
                    print("Error: ", error)
                }
        }
    }

    func sendNotification(lon: Float, lat: Float) {
        // Code here
        let notificationContent = UNMutableNotificationContent()

        // Add the content to the notification content
        let notificationText = "Pothole detected at lon: " + String(lon) + " lat: " + String(lat)
        notificationContent.title = "POTHOLE DETECTION"
        if (lon == 0.0 && lat == 0.0){
            notificationContent.body = "Welcome to Pothole Detection"
        }
        else{
            notificationContent.body = notificationText
        }
        notificationContent.badge = NSNumber(value: 3)

        // Add an attachment to the notification content
        if let url = Bundle.main.url(forResource: "AppIcon",
                                        withExtension: "png") {
            if let attachment = try? UNNotificationAttachment(identifier: "AppIcon",
                                                                url: url,
                                                                options: nil) {
                notificationContent.attachments = [attachment]
            }
        }
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                            repeats: false)
            let request = UNNotificationRequest(identifier: "testNotification",
                                                content: notificationContent,
                                                trigger: trigger)
            
            userNotificationCenter.add(request) { (error) in
                if let error = error {
                    print("Notification Error: ", error)
                }
            }
    }
    
        

        func myAccelerometer() {
            print("Start Accelerometer")
//            let object: [String: Any] = [
//                "name": "Test" as NSObject,
//                "Test2" : "Test3"
//            ]
//            database.child("TestChild").setValue(object)
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
                    
                   //Get location at this instance
                    guard let coordinate = self.locationManager.location?.coordinate else {return}
                    //Convert location to CLLocationCoordinate2D so pin function can use it
                    let pinLocation = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    
                    if (abs(self.x_arr[self.x_arr.count - 1] - self.x_arr[self.x_arr.count - 2]) > abs(0.5)) && self.x_arr.count > 1{
                        print("Pothole Detected because ", self.x_arr[self.x_arr.count - 1], " - ", self.x_arr[self.x_arr.count - 2] )
                        self.sendNotification(lon: Float(coordinate.longitude), lat: Float(coordinate.latitude))
                        self.putPinOnMap(location: pinLocation)
                    }
                    
                    if (abs(self.y_arr[self.y_arr.count - 1] - self.y_arr[self.y_arr.count - 2]) > abs(0.5)) && self.y_arr.count > 1{
                        print("Pothole Detected")
                        self.sendNotification(lon: Float(coordinate.longitude), lat: Float(coordinate.latitude))
                        self.putPinOnMap(location: pinLocation)
                    }
                }
            }
            
            return
        }
    func stopMyAccelerometer() {
        motion.stopAccelerometerUpdates()
    }

    
    func putPinOnMap(location: CLLocationCoordinate2D){
        let pin = MKPointAnnotation()
        pin.title = "Pothole"
        pin.coordinate = location
        mapView.addAnnotation(pin)
        print("placed pin")
    }
}
