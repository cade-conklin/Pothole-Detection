//
//  ViewController.swift
//  Pothole-Detection
//
//  Created by Cade Conklin on 11/16/20.
//

import UIKit
import CoreMotion

public var carType = ""

class ViewController: UIViewController {

    
    @IBOutlet weak var StartButton: UIButton!
    var car = Car(type: "Sedan")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StartButton.center = self.view.center
    }

       

}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

