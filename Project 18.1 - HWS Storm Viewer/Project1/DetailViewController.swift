//
//  DetailViewController.swift
//  Project1
//
//  Created by Thomas Kellough on 6/13/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var totalPictures = 0
    var pictureSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImages()
    }
    
    func loadImages() {
        title = "Picture \(pictureSelected) of \(totalPictures)"
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
