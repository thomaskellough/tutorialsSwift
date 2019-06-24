//
//  Photo.swift
//  Project1
//
//  Created by Thomas Kellough on 6/24/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class Photo: NSObject {
    var image = String()
    var name = String()
    
    init(image: String, name: String) {
        self.image = image
        self.name = name
    }

}
