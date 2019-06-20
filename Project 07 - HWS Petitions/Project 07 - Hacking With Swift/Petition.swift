//
//  petition.swift
//  Project 07 - Hacking With Swift
//
//  Created by Thomas Kellough on 6/19/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
