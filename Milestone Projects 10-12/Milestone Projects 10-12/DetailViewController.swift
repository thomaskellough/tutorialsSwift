//
//  DetailViewController.swift
//  Milestone Projects 10-12
//
//  Created by Thomas Kellough on 6/26/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: Image?
    var imageContents: String?
    var path: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedImage != nil {
            imageView.image = UIImage(contentsOfFile: path!.path)
        }
    }
    

}
