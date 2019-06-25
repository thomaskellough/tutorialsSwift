//
//  Person.swift
//  Project 10 - HWS Names to Faces
//
//  Created by Thomas Kellough on 6/23/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {
    var name = String()
    var image = String()
    
    // This class needs it's own initializer!
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    // Reading things out from the disc
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    // Writing things to the disc
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
    }
    
}
