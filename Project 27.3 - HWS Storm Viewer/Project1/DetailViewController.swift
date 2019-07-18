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
        
        title = "Picture \(pictureSelected) of \(totalPictures)"
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
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
    
    @objc func shareTapped() {
        let image = renderImage()
        
        let vc = UIActivityViewController(activityItems: [image, selectedImage?.replacingOccurrences(of: ".jpg", with: "") as Any], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.backBarButtonItem
        present(vc, animated: true)
    }
    
    func renderImage() -> UIImage {
        if let imageName = selectedImage {
            if let size = imageView.image?.size {
                
                let renderer = UIGraphicsImageRenderer(size: size)
                
                let image = renderer.image { ctx in
                    let photo = UIImage(named: imageName)
                    photo?.draw(at: CGPoint(x: 0, y: 0))
                    
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.alignment = .center
                    
                    let attrs: [NSAttributedString.Key: Any] = [
                        .font: UIFont.systemFont(ofSize: 48),
                        .paragraphStyle: paragraphStyle
                    ]
                    
                    let string = "From Storm Viewer"
                    let attributedString = NSAttributedString(string: string, attributes: attrs)
                    
                    attributedString.draw(with: CGRect(x: size.width / 6, y: size.height / 2, width: size.width, height: size.height), options: .usesLineFragmentOrigin, context: nil)
                    
                }
                return image
            }
        }
        fatalError("Image could not render correctly")
    }

}
