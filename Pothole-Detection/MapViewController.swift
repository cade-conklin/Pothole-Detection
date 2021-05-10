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
    
    
    @IBAction func TrackLocationButtonEvent(_ sender: Any) {
        mapView.setUserTrackingMode(MKUserTrackingMode.followWithHeading, animated: true)
    }
    @IBOutlet weak var TrackLocationButton: UIButton!
    @IBOutlet weak var StopDrivingButton: UIButton!
    @IBAction func StopDrivingButtonEvent(_ sender: Any) {
        stopMyAccelerometer()
        startDrive = false
        StartDrivingButton.isHidden = false
        StopDrivingButton.isHidden = true
        TrackLocationButton.isHidden = true
        mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: false)
        guard let coordinate = locationManager.location?.coordinate else {return}
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 400, longitudinalMeters: 400)
        mapView.setRegion(coordinateRegion, animated: true)
        
        mapView.showsUserLocation = true
    }
    @IBOutlet weak var StartDrivingButton: UIButton!
    @IBAction func StartDrivingButtonEvent(_ sender: Any) {
        startDrive = true
        timer.invalidate() // just in case this button is tapped multiple times

                // start the timer
                timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        myAccelerometer()
        StartDrivingButton.isHidden = true
        StopDrivingButton.isHidden = false
        TrackLocationButton.isHidden = false
        mapView.setUserTrackingMode(MKUserTrackingMode.followWithHeading, animated: true)
        
        
    }
    private let database = Database.database().reference()
    
    let locationManager:CLLocationManager = CLLocationManager()
    let userNotificationCenter = UNUserNotificationCenter.current()

    var x_arr = Array<Double>(repeating: 0, count: 20)
    var y_arr = Array<Double>(repeating: 0, count: 20)
    var z_arr = Array<Double>(repeating: 0, count: 20)
    
    
    var motion = CMMotionManager()
    var onMapView = false;
    
    var changeAcc = 0.4
    
    var startDrive = false
    
    var counter = 0
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        StartDrivingButton.layer.cornerRadius = 0.5 * StartDrivingButton.bounds.size.width
        StartDrivingButton.clipsToBounds = true
        StartDrivingButton.layer.borderWidth = 4
        StartDrivingButton.layer.borderColor = UIColor.darkGray.cgColor
        StartDrivingButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        StartDrivingButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        StartDrivingButton.layer.shadowOpacity = 1.0
        StartDrivingButton.layer.shadowRadius = 0.0
        StartDrivingButton.layer.masksToBounds = false
        
        StopDrivingButton.layer.cornerRadius = 0.5 * StopDrivingButton.bounds.size.width
        StopDrivingButton.clipsToBounds = true
        StopDrivingButton.layer.borderWidth = 4
        StopDrivingButton.layer.borderColor = UIColor.darkGray.cgColor
        StopDrivingButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        StopDrivingButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        StopDrivingButton.layer.shadowOpacity = 1.0
        StopDrivingButton.layer.shadowRadius = 0.0
        StopDrivingButton.layer.masksToBounds = false
        StopDrivingButton.isHidden = true
        
        TrackLocationButton.layer.cornerRadius = 0.5 * TrackLocationButton.bounds.size.width
        TrackLocationButton.clipsToBounds = true
        TrackLocationButton.layer.borderWidth = 4
        TrackLocationButton.layer.borderColor = UIColor.darkGray.cgColor
        TrackLocationButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        TrackLocationButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        TrackLocationButton.layer.shadowOpacity = 1.0
        TrackLocationButton.layer.shadowRadius = 0.0
        TrackLocationButton.layer.masksToBounds = false
        TrackLocationButton.isHidden = true
        
        
        // Do any additional setup after loading the view.
        let car_saved = UserDefaults.standard.object(forKey: "MyKey")
        carType = car_saved as! String
        print(carType)
    
        if carType == "Sedan" {
            changeAcc = 0.35
        }
        else if carType == "SUV" {
            changeAcc = 0.25
        }
        else if carType == "Truck" {
            changeAcc = 0.2
        }
        else {
            changeAcc = 0.4
        }
        print("map loaded")
        self.requestNotificationAuthorization()
        self.sendNotification(lon: 0.0, lat: 0.0)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("map appeared")
        startLocationCollection(startDrive: startDrive)
        

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stopMyAccelerometer()
        print("Map is gone")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //CLLocation objects passed in store longitude latitude coordinates
        guard let first = locations.first else { //If there not at least one element, return
            print("Failed to get user location")
            return
        }
        print("HEREHEREHEREHERE")
        let newLocation = CLLocation(latitude: first.coordinate.latitude, longitude: first.coordinate.longitude)
        let radius:CLLocationDistance = 1000
        let region = MKCoordinateRegion(center: newLocation.coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        mapView.setRegion(region, animated: true)
        
    }
    
    func startLocationCollection(startDrive: Bool){
        //Request location from user- currently set to be able to use location in background
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone //Location will constantly update
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        //populates map with all potholes that have previosly been recorded
        self.database.child("Potholes").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let pothole = snapshot.value as? NSDictionary {
                    let longitude = pothole["longitude"] as? Double
                    let latitude = pothole["latitude"] as? Double
                 //   let number = pothole["number"] as? String
                    if(pothole["number"] != nil) {
                       // print("Number: ", (pothole["number"]) as! Int)
                        let number = String((pothole["number"]) as! Int)
                        let pinlocation = CLLocationCoordinate2D(latitude: latitude ?? 0, longitude: longitude ?? 0)
                        self.putPinOnMap(location: pinlocation, potholeNum: number)
                        print("pothole: ", pothole)
                    }
                    else {
                        let number = "no_num"
                   // print("Number: ", (pothole["number"]) as! Int)
                        let pinlocation = CLLocationCoordinate2D(latitude: latitude ?? 0, longitude: longitude ?? 0)
                        self.putPinOnMap(location: pinlocation, potholeNum: number)
                        print("pothole: ", pothole)
                    }
                }
            }
        })

        
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
//                "latitude": Float(coordinate.latitude),
//                "longitude" : Float(coordinate.longitude)
//            ]
//            database.child("Potholes/Pothole_" + String(Int.random(in: 0..<10000))).setValue(object)

            //populates map with all potholes that have previosly been recorded
            self.database.child("Potholes").observeSingleEvent(of: .value, with: { (snapshot) in
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot,
                       let pothole = snapshot.value as? NSDictionary {
                        let longitude = pothole["longitude"] as? Double
                        let latitude = pothole["latitude"] as? Double
                     //   let number = pothole["number"] as? String
                        if(pothole["number"] != nil) {
                           // print("Number: ", (pothole["number"]) as! Int)
                            let number = String((pothole["number"]) as! Int)
                            let pinlocation = CLLocationCoordinate2D(latitude: latitude ?? 0, longitude: longitude ?? 0)
                            self.putPinOnMap(location: pinlocation, potholeNum: number)
                            print("pothole: ", pothole)
                        }
                        else {
                            let number = "no_num"
                       // print("Number: ", (pothole["number"]) as! Int)
                            let pinlocation = CLLocationCoordinate2D(latitude: latitude ?? 0, longitude: longitude ?? 0)
                            self.putPinOnMap(location: pinlocation, potholeNum: number)
                            print("pothole: ", pothole)
                        }
                    }
                }
            })
            
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
                    
                    //Date and time at this instance:
                    let date = Date()
                    let formatD = DateFormatter()
                    let formatT = DateFormatter()
                    formatD.dateFormat = "MM/dd/yyyy"
                    formatT.dateFormat = "HH:mm"
                    let formattedDate = formatD.string(from: date)
                    let formattedTime = formatT.string(from: date)
                    
                   //Get location at this instance
                    guard let coordinate = self.locationManager.location?.coordinate else {return}
                    //Convert location to CLLocationCoordinate2D so pin function can use it
                    let pinLocation = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    //creating object that will be sent to DB if pothole is detected
                    let object: [String: Any] = [
                        "number" : String(Int.random(in: 0..<10000)),
                        "latitude": Float(coordinate.latitude),
                        "longitude" : Float(coordinate.longitude),
                        "num_reports" : 1,
                        "time" : formattedTime,
                        "date" : formattedDate
                    ]
                    
                    if (self.counter > 10) {
                        if (abs(self.x_arr[self.x_arr.count - 1] - self.x_arr[self.x_arr.count - 2]) > abs(self.changeAcc)) && self.x_arr.count > 10{
                            print("Pothole Detected because ", self.x_arr[self.x_arr.count - 1], " - ", self.x_arr[self.x_arr.count - 2] )
                            self.sendNotification(lon: Float(coordinate.longitude), lat: Float(coordinate.latitude))
    //                        let object: [String: Any] = [
    //                            "latitude": Float(coordinate.latitude),
    //                            "longitude" : Float(coordinate.longitude)
    //                        ]
                            let potholeNum = object["number"] as! String
                            self.database.child("Potholes/Pothole_" + potholeNum).setValue(object)
                            self.putPinOnMap(location: pinLocation, potholeNum: potholeNum)
                        }
                        
                        if (abs(self.y_arr[self.y_arr.count - 1] - self.y_arr[self.y_arr.count - 2]) > abs(self.changeAcc)) && self.y_arr.count > 10{
                            print("Pothole Detected")
                            self.sendNotification(lon: Float(coordinate.longitude), lat: Float(coordinate.latitude))
    //                        let object: [String: Any] = [
    //                            "latitude": Float(coordinate.latitude),
    //                            "longitude" : Float(coordinate.longitude)
    //                            "
    //                        ]
                            let potholeNum = object["number"] as! String
                            self.database.child("Potholes/Pothole_" + potholeNum).setValue(object)
                            self.putPinOnMap(location: pinLocation, potholeNum: potholeNum)
                        }
                    }
                }
            }
            
            return
        }
    func stopMyAccelerometer() {
        motion.stopAccelerometerUpdates()
//        x_arr.removeAll()
//        y_arr.removeAll()
//        z_arr.removeAll()
    }

    
    func putPinOnMap(location: CLLocationCoordinate2D, potholeNum: String){
        let pin = MKPointAnnotation()
        pin.title = String("Pothole_" + potholeNum)
        pin.coordinate = location
        mapView.addAnnotation(pin)
        print("placed pin " + pin.title!)
    }
    
    @objc func timerAction() {
            counter += 1
        }
}
