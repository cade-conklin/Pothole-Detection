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

    @IBOutlet weak var Wheel: UIImageView!
    
    @IBOutlet weak var SelectCarButton: UIButton!
    @IBOutlet weak var StartButton: UIButton!
    var car = Car(type: "Sedan")
    var timer = Timer()
    var rotAngle: CGFloat = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StartButton.layer.cornerRadius = 0.5 * StartButton.bounds.size.width
        StartButton.clipsToBounds = true
        StartButton.layer.borderWidth = 4
        StartButton.layer.borderColor = UIColor.darkGray.cgColor
        StartButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        StartButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        StartButton.layer.shadowOpacity = 1.0
        StartButton.layer.shadowRadius = 0.0
        StartButton.layer.masksToBounds = false
        
        
        SelectCarButton.layer.cornerRadius = 0.5 * SelectCarButton.bounds.size.width
        SelectCarButton.layer.borderWidth = 4
        SelectCarButton.layer.borderColor = UIColor.darkGray.cgColor
        SelectCarButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        SelectCarButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        SelectCarButton.layer.shadowOpacity = 1.0
        SelectCarButton.layer.shadowRadius = 0.0
        SelectCarButton.layer.masksToBounds = false
        SelectCarButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        SelectCarButton.titleLabel?.adjustsFontSizeToFitWidth = true;

        

        activateTimer()
    }
    override func viewDidAppear(_ animated: Bool) {
        let car_saved = UserDefaults.standard.object(forKey: "MyKey")
        carType = car_saved as! String
        if carType == "Sedan" {
            //let image = UIImage(named: "SelectSedan.png")
            //SelectCarButton.setImage(image, for: .normal)
            SelectCarButton.setTitle("Car Type: Sedan", for: .normal)
            
        }
        else if carType == "SUV" {
            //let image = UIImage(named: "SelectSuv.png")
            //SelectCarButton.setImage(image, for: .normal)
            SelectCarButton.setTitle("Car Type: SUV", for: .normal)
            

        }
        else if carType == "Truck" {
            //let image = UIImage(named: "SelectTruck.png")
            //SelectCarButton.setImage(image, for: .normal)
            SelectCarButton.setTitle("Car Type: Truck", for: .normal)
            

        }
        else {
            //let image = UIImage(named: "SelectSedan.png")
            //SelectCarButton.setImage(image, for: .normal)
            SelectCarButton.setTitle("Car Type: Sedan", for: .normal)
           
        }
    }
    
    func activateTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector:#selector(ViewController.updateCounter), userInfo: nil, repeats: true)
        }

    @objc func updateCounter() {
            rotAngle += 120.0
            UIView.animate(withDuration: 2.0, animations: {
                self.Wheel.transform = CGAffineTransform(rotationAngle: (self.rotAngle * CGFloat(Double.pi)) / 180.0)
          })
        }

       

}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


