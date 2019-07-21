//
//  Person.swift
//  Project 10 - HWS Names to Faces
//
//  Created by Thomas Kellough on 6/23/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {
    var name = String()
    var image = String()
    
    // This class needs it's own initializer!
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
