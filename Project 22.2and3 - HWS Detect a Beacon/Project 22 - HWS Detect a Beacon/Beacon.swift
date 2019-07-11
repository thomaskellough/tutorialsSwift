//
//  Beacon.swift
//  Project 22 - HWS Detect a Beacon
//
//  Created by Thomas Kellough on 7/10/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import CoreLocation
import Foundation

struct Beacon {
    var uuid: UUID?
    var major: UInt16?
    var minor: UInt16?
    var identifier: String?
    
    init(uuid: UUID, major: UInt16, minor: UInt16, identifier: String) {
        self.uuid = uuid
        self.major = major
        self.minor = minor
        self.identifier = identifier
    }
}
