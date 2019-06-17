//
//  WebsiteListViewController.swift
//  Project 04 - Hacking With Swift
//
//  Created by Thomas Kellough on 6/17/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class WebsiteListViewController: UITableViewController {
    
    var websites = ["hackingwithswift.com", "google.com"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return websites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
}
