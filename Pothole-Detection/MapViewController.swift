//
//  MapViewController.swift
//  Pothole-Detection
//
//  Created by Odyssey Wilson on 11/17/20.
//

import Foundation
import UIKit

class MapViewController: UIViewController {


    @IBAction func closeButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "closeMapSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("map loaded")
    }
}
