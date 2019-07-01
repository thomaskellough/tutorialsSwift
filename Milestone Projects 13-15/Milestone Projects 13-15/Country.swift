//
//  Country.swift
//  Milestone Projects 13-15
//
//  Created by Thomas Kellough on 6/27/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import Foundation

struct Country: Codable {
    var country: String
    var capital: String?
    var population: Int
    var languages: [[String: String]]
    var currency: String
    var area : Int
    var populationIncreasing: Bool
    
    enum CodingKeys: String, CodingKey {
        case country = "country"
        case capital = "capital"
        case population = "population"
        case languages = "languages"
        case currency = "currency"
        case area = "area (sq mi)"
        case populationIncreasing = "population increasing"
    }
}
