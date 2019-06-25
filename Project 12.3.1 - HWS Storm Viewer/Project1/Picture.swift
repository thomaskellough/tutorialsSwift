//
//  Picture.swift
//  Project1
//
//  Created by Thomas Kellough on 6/25/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class Picture: NSObject, Codable {
    var image = String()
    var views = Int()
    
    init(image: String, views: Int) {
        self.image = image
        self.views = views
    }
}
