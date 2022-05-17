//
//  ViewController.swift
//  EMICalculator
//
//  Created by Karan Karthic Neelamegan on 12/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    var person:Person?
    var pet:Pet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        person = Person()
        pet = Pet()
        
        person?.pet = pet
        pet?.owner = person
        
        
        person = nil
        
        print(pet?.owner)
        
    }
    
}

class Person{
    
    var name = "st"
    var pet:Pet?
    init() {
        
    }

    deinit {
        print("person")
    }
    
    
}

class Pet{

    var name = "strr"
    weak var owner:Person?
    init() {
        
    }
    
    deinit {
        print("pet")
    }
}

