//
//  Image.swift
//  Milestone Projects 10-12
//
//  Created by Thomas Kellough on 6/26/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class Image: NSObject, Codable {
    var image = String()
    var caption = String()

    init(image: String, caption: String) {
        self.image = image
        self.caption = caption
    }
}
