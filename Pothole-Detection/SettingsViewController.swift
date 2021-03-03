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
        let vc = ViewController(nibName: "ViewController", bundle: nil)
        vc.car.setType(type: "Sedan")
        carType = "Sedan"
        fillButton(button: SedanButton)
        unfillButton(button: SUVButton)
        unfillButton(button: TruckButton)

        
    }
    @IBAction func SUVButtonEvent(_ sender: Any) {
        print("Set as SUV")
        let vc = ViewController(nibName: "ViewController", bundle: nil)
        vc.car.setType(type: "SUV")
        carType = "SUV"
        fillButton(button: SUVButton)
        unfillButton(button: SedanButton)
        unfillButton(button: TruckButton)
    }
    @IBAction func TruckButtonEvent(_ sender: Any) {
        print("Set as Truck")
        let vc = ViewController(nibName: "ViewController", bundle: nil)
        vc.car.setType(type: "Truck")
        carType = "Truck"
        fillButton(button: TruckButton)
        unfillButton(button: SUVButton)
        unfillButton(button: SedanButton)


    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
        if carType == "Sedan" {
            fillButton(button: SedanButton)
        }
        else if carType == "SUV" {
            fillButton(button: SUVButton)
        }
        else if carType == "Truck" {
            fillButton(button: TruckButton)
        }
        else {
            unfillButton(button: SUVButton)
            unfillButton(button: SedanButton)
            unfillButton(button: TruckButton)
        }
    }
    
    func setUpButtons() {
        SedanButton.layer.cornerRadius = 5
        SedanButton.layer.borderWidth = 1
        SedanButton.layer.borderColor = UIColor.darkGray.cgColor
        
        SUVButton.layer.cornerRadius = 5
        SUVButton.layer.borderWidth = 1
        SUVButton.layer.borderColor = UIColor.darkGray.cgColor
        
        TruckButton.layer.cornerRadius = 5
        TruckButton.layer.borderWidth = 1
        TruckButton.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func fillButton(button: UIButton) {
        button.backgroundColor = UIColor.systemGreen
    }
    
    func unfillButton(button: UIButton) {
        button.backgroundColor = .clear
    }

}
