//
//  records.swift
//  Project2
//
//  Created by Thomas Kellough on 6/25/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class Records: NSObject, Codable {
    var highestScore = Int()
    
    init(highestScore: Int) {
        self.highestScore = highestScore
    }
}
