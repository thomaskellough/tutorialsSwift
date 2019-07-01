//
//  Capital.swift
//  Project 16 - HWS Capital Cities
//
//  Created by Thomas Kellough on 7/1/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
