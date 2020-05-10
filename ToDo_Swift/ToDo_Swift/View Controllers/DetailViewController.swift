//
//  DetailViewController.swift
//  ToDo_Swift
//
//  Created by Thomas Kellough on 5/10/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.timestamp!.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    var detailItem: Event? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

