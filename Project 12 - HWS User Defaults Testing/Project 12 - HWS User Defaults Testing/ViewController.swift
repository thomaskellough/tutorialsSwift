//
//  ViewController.swift
//  Project 12 - HWS User Defaults Testing
//
//  Created by Thomas Kellough on 6/25/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        defaults.set(25, forKey: "Age")  // Returns int if existed, or 0 if not
        defaults.set(true, forKey: "UseFaceID")  // Returns bool if existed, or false if not
        defaults.set(CGFloat.pi, forKey: "Pi")  // Returns a float if existed, or 0.0 if not
        
        defaults.set("Thomas Kellough", forKey: "Name")
        defaults.set(Date(), forKey: "LastRun")
        
        let array = ["Hello", "World!"]
        defaults.set(array, forKey: "SavedArray")
        
        let dict = ["Name": "Thomas", "Country": "US"]
        defaults.set(dict, forKey: "SavedDictionary")
        
        let savedInteger = defaults.integer(forKey: "Age")
        let savedBoolean = defaults.bool(forKey: "UseFaceID")
        let savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()  // If array doesn't exist, will make an empty array
        let savedDictionary = defaults.object(forKey: "SavedDictionary") as? [String: String] ?? [String: String]()
    
    }


}

