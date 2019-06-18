//
//  WebsiteListViewController.swift
//  Project 04 - Hacking With Swift
//
//  Created by Thomas Kellough on 6/17/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class WebsiteListViewController: UITableViewController {
    
    var websites = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let approvedWebsitesURL = Bundle.main.url(forResource: "approvedWebsites", withExtension: "txt") {
            if let approvedWebsites = try? String(contentsOf: approvedWebsitesURL) {
                websites = approvedWebsites.components(separatedBy: "\n")
            } else {
                websites = ["hackingwithswift.com"]
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            vc.selectedWebsite = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
