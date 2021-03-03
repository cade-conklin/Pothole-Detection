//
//  Car.swift
//  Pothole-Detection
//
//  Created by Cade Conklin on 2/20/21.
//

import Foundation

class Car  {
     
    // type property
    var type: String = "";
     

    // Default Constructor (No parameter)
    // (Used to create instance).
    init()  {
         
    }
     
    // Contructor with 1 parameters.
    // (Used to create instance)
    // self.type refers to the type property of the class
    init (type: String)  {
        self.type = type
    }
     
    // A method gets the car type.
    func getType()  -> String  {
        return type
    }
    
    func setType(type: String) -> Void {
        self.type = type
    }
     
     
}
