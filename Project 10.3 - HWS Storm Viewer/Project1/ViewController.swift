//
//  ViewController.swift
//  Project1
//
//  Created by Thomas Kellough on 6/13/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var pictures = [String]()
    var photos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recommendApp))
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items{
            if item.hasPrefix("nssl"){
                // this is a picture to load
                pictures.append(item)
            }
            pictures.sort()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Image", for: indexPath) as? PhotoCell else {
            fatalError("Unable to deque photo cell")
        }
        
        let photo = pictures[indexPath.row]
        cell.imageView.image = UIImage(named: photo)
        cell.imageView.layer.borderColor = UIColor.lightGray.cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 3
        cell.name.text = pictures[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.pictureSelected = indexPath.row + 1
            vc.totalPictures = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func recommendApp() {
        /*
         NOTE: I don't think I can link this app since it's not on the app store. I created
         a link for the facebook app. Just change the appLink URL to whichever app you
         want to share
         */
        let textToShare = "Check out this awesome app!"
        let appLink = "https://apps.apple.com/us/app/facebook/id284882215"
        let objectToShare = [textToShare, appLink]
        let vc = UIActivityViewController(activityItems: objectToShare, applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.backBarButtonItem
        present(vc, animated: true)
    }
}

