//
//  Words.swift
//  Project 05 - Hacking With Swift
//
//  Created by Thomas Kellough on 6/25/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class Words: NSObject, Codable {
    var currentWord = String()
    var usedWords = [String]()
    
    init(currentWord: String, usedWords: [String]) {
        self.currentWord = currentWord
        self.usedWords = usedWords
    }
}
