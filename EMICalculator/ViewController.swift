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
    var paragraph: HTMLElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        person = Person()
//        pet = Pet()
//
//        person?.pet = pet
//        pet?.owner = person
//
//
//        person = nil
//
//        print(pet?.owner)
        
        paragraph = HTMLElement(name: "p", text: "hello, world")
        print(paragraph!.asHTML())
        
        paragraph = nil
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


class HTMLElement {

    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        [self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }

}
