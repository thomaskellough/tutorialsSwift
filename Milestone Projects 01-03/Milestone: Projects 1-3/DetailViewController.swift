//
//  DetailViewController.swift
//  Milestone: Projects 1-3
//
//  Created by Thomas Kellough on 6/16/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareImage))
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
            imageView.layer.borderWidth = 2
            imageView.layer.borderColor = UIColor.black.cgColor
        }
        
    }
    
    @objc func shareImage() {
        guard let image = imageView.image?.pngData() else {
            print("No image found")
            return
        }
        let textToShare = selectedImage?.replacingOccurrences(of: "@3x.png", with: "").uppercased()
        let objectToShare = [textToShare!, image] as [Any]
        
        let vc = UIActivityViewController(activityItems: objectToShare, applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.backBarButtonItem
        present(vc, animated: true)
        
    }

}
