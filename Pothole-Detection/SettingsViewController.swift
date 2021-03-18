//
//  SettingsViewController.swift
//  Pothole-Detection
//
//  Created by Cade Conklin on 2/20/21.
//
import UIKit
import Foundation

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var SedanButton: UIButton!
    
    @IBOutlet weak var SUVButton: UIButton!
    @IBOutlet weak var TruckButton: UIButton!
    
    @IBAction func SedanButtonEvent(_ sender: Any) {
        print("Set as Sedan")
        UserDefaults.standard.set("Sedan", forKey: "MyKey")
        let vc = ViewController(nibName: "ViewController", bundle: nil)
        vc.car.setType(type: "Sedan")
        carType = "Sedan"
        fillButton(button: SedanButton)
        unfillButton(button: SUVButton)
        unfillButton(button: TruckButton)
        self.showToast(message: "Your car was set to Sedan", font: .systemFont(ofSize: 12.0))

        
    }
    @IBAction func SUVButtonEvent(_ sender: Any) {
        print("Set as SUV")
        UserDefaults.standard.set("SUV", forKey: "MyKey")
        let vc = ViewController(nibName: "ViewController", bundle: nil)
        vc.car.setType(type: "SUV")
        carType = "SUV"
        fillButton(button: SUVButton)
        unfillButton(button: SedanButton)
        unfillButton(button: TruckButton)
        self.showToast(message: "Your car was set to SUV", font: .systemFont(ofSize: 12.0))
    }
    @IBAction func TruckButtonEvent(_ sender: Any) {
        print("Set as Truck")
        UserDefaults.standard.set("Truck", forKey: "MyKey")
        let vc = ViewController(nibName: "ViewController", bundle: nil)
        vc.car.setType(type: "Truck")
        carType = "Truck"
        fillButton(button: TruckButton)
        unfillButton(button: SUVButton)
        unfillButton(button: SedanButton)
        self.showToast(message: "Your car was set to Truck", font: .systemFont(ofSize: 12.0))


    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
        let car_saved = UserDefaults.standard.object(forKey: "MyKey")
        carType = car_saved as! String
        if carType == "Sedan" {
            fillButton(button: SedanButton)
            unfillButton(button: SUVButton)
            unfillButton(button: TruckButton)
        }
        else if carType == "SUV" {
            fillButton(button: SUVButton)
            unfillButton(button: SedanButton)
            unfillButton(button: TruckButton)
        }
        else if carType == "Truck" {
            fillButton(button: TruckButton)
            unfillButton(button: SUVButton)
            unfillButton(button: SedanButton)
        }
        else {
            unfillButton(button: SUVButton)
            unfillButton(button: SedanButton)
            unfillButton(button: TruckButton)
        }
    }
    
    func setUpButtons() {
        SedanButton.layer.cornerRadius = 5
        SedanButton.layer.borderWidth = 4
        SedanButton.layer.borderColor = UIColor.darkGray.cgColor
        SedanButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        SedanButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        SedanButton.layer.shadowOpacity = 1.0
        SedanButton.layer.shadowRadius = 0.0
        //SedanButton.layer.masksToBounds = false
        
        SUVButton.layer.cornerRadius = 5
        SUVButton.layer.borderWidth = 4
        SUVButton.layer.borderColor = UIColor.darkGray.cgColor
        SUVButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        SUVButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        SUVButton.layer.shadowOpacity = 1.0
        SUVButton.layer.shadowRadius = 0.0
        //SUVButton.layer.masksToBounds = false
        
        
        TruckButton.layer.cornerRadius = 5
        TruckButton.layer.borderWidth = 4
        TruckButton.layer.borderColor = UIColor.darkGray.cgColor
        TruckButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        TruckButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        TruckButton.layer.shadowOpacity = 1.0
        TruckButton.layer.shadowRadius = 0.0
        //TruckButton.layer.masksToBounds = false
        
    }
    
    func fillButton(button: UIButton) {
        button.backgroundColor = UIColor.systemTeal
    }
    
    func unfillButton(button: UIButton) {
        button.backgroundColor = UIColor.white
    }
    
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

}
