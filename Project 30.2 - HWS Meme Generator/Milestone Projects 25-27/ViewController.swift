//
//  ViewController.swift
//  Milestone Projects 25-27
//
//  Created by Thomas Kellough on 7/17/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    var topText: String?
    var bottomText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPicture))
    }
    
    @objc func addPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        imageView.image = image
        dismiss(animated: true)
    }
    
    @IBAction func topTextTapped(_ sender: UIButton) {
        guard let image = self.imageView.image else { return }
        let ac = UIAlertController(title: "Add top text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak self, weak ac] _ in
            guard let text = ac?.textFields?[0].text else { return }
            self?.topText = text
            self?.renderImage(image: image)
        }))
        present(ac, animated: true)
    }
    
    @IBAction func bottomTextTapped(_ sender: UIButton) {
        guard let image = self.imageView.image else { return }
        let ac = UIAlertController(title: "Add top text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak self, weak ac] _ in
            guard let text = ac?.textFields?[0].text else { return }
            self?.bottomText = text
            self?.renderImage(image: image)
        }))
        present(ac, animated: true)
    }
    
    func renderImage(image: UIImage) {
        // To do: Fix text so user has limited character
        // To do: Ensure that text can't wrap past the image
        // To do: Allow user to delete text and start over without uploading the picture again
        let size = image.size
        let renderer = UIGraphicsImageRenderer(size: size)
        let renderedImage = renderer.image { ctx in
            let photo = image
            photo.draw(at: CGPoint(x: 0, y: 0))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.black
            shadow.shadowBlurRadius = 5
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 94),
                .foregroundColor: UIColor.white,
                .shadow: shadow,
                .paragraphStyle: paragraphStyle
            ]
            if let top = self.topText {
                let attributedString = NSAttributedString(string: top.uppercased(), attributes: attrs)
                attributedString.draw(with: CGRect(x: 0, y: 5, width: size.width, height: size.height), options: .usesLineFragmentOrigin, context: nil)
                self.topText = nil
            }
            
            if let bottom = self.bottomText {
                let attributedString = NSAttributedString(string: bottom.uppercased(), attributes: attrs)
                attributedString.draw(with: CGRect(x: 0, y: size.height - 110, width: size.width, height: size.height), options: .usesLineFragmentOrigin, context: nil)
                self.bottomText = nil
            }
        }
        self.imageView.image = renderedImage
        
    }
    
}

