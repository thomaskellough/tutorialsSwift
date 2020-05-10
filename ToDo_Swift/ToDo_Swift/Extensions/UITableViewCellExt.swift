//
//  UITableViewCellExt.swift
//  ToDo_Swift
//
//  Created by Thomas Kellough on 5/10/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    func debugQuickLookObject() -> AnyObject {
        return "This is the value of textLabel: \(textLabel!.text!)" as AnyObject
    }
}
