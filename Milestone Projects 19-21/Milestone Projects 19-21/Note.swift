//
//  Note.swift
//  Milestone Projects 19-21
//
//  Created by Thomas Kellough on 7/3/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class Note: NSObject, Codable {
    var title = String()
    var body = String()
    var date = String()
    
    init(title: String, body: String, date: String) {
        self.title = title
        self.body = body
        self.date = date
    }
    
    
}

