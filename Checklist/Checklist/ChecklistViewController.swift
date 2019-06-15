//
//  ViewController.swift
//  Checklist
//
//  Created by Thomas Kellough on 5/23/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // Configure number of rows in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    // Called every time a table view needs a cell. This method configures a cell to show certain kinds of data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        
        // Get label tag
        if let label = cell.viewWithTag(1000) as? UILabel {
            if indexPath.row == 0 {
                label.text = "Run a marathon"
            } else {
                label.text = "Sleep"
            }
        }
        
        return cell
    }

}

