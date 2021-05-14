//
//  ViewController.swift
//  Pothole-Detection
//
//  Created by Cade Conklin on 11/16/20.
//

import UIKit
import CoreMotion


class UserViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var LoginButton: UIButton!
    var username:String!
    @IBOutlet weak var UserLabel: UILabel!
    @IBOutlet weak var PasswordLabel: UILabel!
    var password:String!
    @IBAction func LoginButtonAction(_ sender: Any) {
        let user_saved = UserDefaults.standard.object(forKey: "userKey")
        let userFalse = user_saved as! String
       
        if username == "odotuser1" && password == "abcdefg" && userFalse == "loggedInFalse" {
            print("Logged in successfully")
            UserDefaults.standard.set("loggedInTrue", forKey: "userKey")
            let vc = ViewController(nibName: "ViewController", bundle: nil)
            vc.loggedInTrue = true
            print(vc.loggedInTrue)
            UsernameField.text = ""
            PasswordField.text = ""
            self.showToast(message: "Logged in as odotuser1", font: .systemFont(ofSize: 12.0))
            LoginButton.backgroundColor = UIColor.red
            LoginButton.setTitle("Logout", for: .normal)
            UsernameField.isHidden = true
            PasswordField.isHidden = true
            UserLabel.isHidden = true
            PasswordLabel.isHidden = true
        }
        else if username != "odotuser1" || password != "abcdefg" && userFalse == "loggedInFalse"{
            print("Logged in failed")
            UserDefaults.standard.set("loggedInFalse", forKey: "userKey")
            let vc = ViewController(nibName: "ViewController", bundle: nil)
            vc.loggedInTrue = false
            print(vc.loggedInTrue)
            self.showToast(message: "Incorrect username or password", font: .systemFont(ofSize: 12.0))
        }
        if userFalse == "loggedInTrue" {
            LoginButton.backgroundColor = UIColor.green
            LoginButton.setTitle("Login", for: .normal)
            UsernameField.isHidden = false
            PasswordField.isHidden = false
            UserLabel.isHidden = false
            PasswordLabel.isHidden = false
            self.showToast(message: "Logged out of odotuser1", font: .systemFont(ofSize: 12.0))
            UserDefaults.standard.set("loggedInFalse", forKey: "userKey")

        }
    }
    @IBOutlet weak var UsernameField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    
    @IBAction func UserSubmit(_ sender: Any) {
        username = UsernameField.text!
    }
    @IBAction func PasswordSubmit(_ sender: Any) {
        password = PasswordField.text!

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Herererereerererere")
        let user_saved = UserDefaults.standard.object(forKey: "userKey")
        let userFalse = user_saved as! String
        if userFalse == "loggedInFalse" {
            LoginButton.backgroundColor = UIColor.green
            LoginButton.setTitle("Login", for: .normal)
            UsernameField.isHidden = false
            PasswordField.isHidden = false
            UserLabel.isHidden = false
            PasswordLabel.isHidden = false
        }
        else {
            LoginButton.backgroundColor = UIColor.red
            LoginButton.setTitle("Logout", for: .normal)
            UsernameField.isHidden = true
            PasswordField.isHidden = true
            UserLabel.isHidden = true
            PasswordLabel.isHidden = true
        }
        UsernameField.delegate=self
        PasswordField.delegate=self
        LoginButton.layer.cornerRadius = 0.5 * LoginButton.bounds.size.width
        LoginButton.clipsToBounds = true
        LoginButton.layer.borderWidth = 4
        LoginButton.layer.borderColor = UIColor.darkGray.cgColor
        LoginButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        LoginButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        LoginButton.layer.shadowOpacity = 1.0
        LoginButton.layer.shadowRadius = 0.0
        LoginButton.layer.masksToBounds = false
//
//
//        SelectCarButton.layer.cornerRadius = 0.5 * SelectCarButton.bounds.size.width
//        SelectCarButton.layer.borderWidth = 4
//        SelectCarButton.layer.borderColor = UIColor.darkGray.cgColor
//        SelectCarButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//        SelectCarButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
//        SelectCarButton.layer.shadowOpacity = 1.0
//        SelectCarButton.layer.shadowRadius = 0.0
//        SelectCarButton.layer.masksToBounds = false
//        SelectCarButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
//        SelectCarButton.titleLabel?.adjustsFontSizeToFitWidth = true;

        

    }
    override func viewDidAppear(_ animated: Bool) {
//        let car_saved = UserDefaults.standard.object(forKey: "MyKey")
//        carType = car_saved as! String
//        if carType == "Sedan" {
//            //let image = UIImage(named: "SelectSedan.png")
//            //SelectCarButton.setImage(image, for: .normal)
//            SelectCarButton.setTitle("Car Type: Sedan", for: .normal)
//
//        }
//        else if carType == "SUV" {
//            //let image = UIImage(named: "SelectSuv.png")
//            //SelectCarButton.setImage(image, for: .normal)
//            SelectCarButton.setTitle("Car Type: SUV", for: .normal)
//
//
//        }
//        else if carType == "Truck" {
//            //let image = UIImage(named: "SelectTruck.png")
//            //SelectCarButton.setImage(image, for: .normal)
//            SelectCarButton.setTitle("Car Type: Truck", for: .normal)
//
//
//        }
//        else {
//            //let image = UIImage(named: "SelectSedan.png")
//            //SelectCarButton.setImage(image, for: .normal)
//            SelectCarButton.setTitle("Car Type: Sedan", for: .normal)
//
//        }
    }
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
        {
            textField.resignFirstResponder()
            return true;
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



