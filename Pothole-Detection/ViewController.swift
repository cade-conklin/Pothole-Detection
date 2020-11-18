//
//  ViewController.swift
//  Pothole-Detection
//
//  Created by Cade Conklin on 11/16/20.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    
    
    @IBOutlet weak var xAccel: UILabel!
    @IBOutlet weak var yAccel: UILabel!
    @IBOutlet weak var zAccel: UILabel!
    
    var motion = CMMotionManager()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            myAccelerometer()
        }

        func myAccelerometer() {
            print("Start Accelerometer")
            motion.accelerometerUpdateInterval = 0.5
            motion.startAccelerometerUpdates(to: OperationQueue.current!) {
                (data, error) in
                print(data as Any)
                if let trueData =  data {
                    self.view.reloadInputViews()
                    let x = trueData.acceleration.x
                    let y = trueData.acceleration.y
                    let z = trueData.acceleration.z
                    self.xAccel!.text = "x: \(Double(x).rounded(toPlaces :3))"
                    self.yAccel!.text = "y: \(Double(y).rounded(toPlaces :3))"
                    self.zAccel!.text = "z: \(Double(z).rounded(toPlaces :3))"
                }
            }
            
            return
        }


}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

