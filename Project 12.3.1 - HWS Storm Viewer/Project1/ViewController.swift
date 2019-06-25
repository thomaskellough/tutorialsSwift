//
//  ViewController.swift
//  Project1
//
//  Created by Thomas Kellough on 6/13/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [Picture]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let defaults = UserDefaults.standard
        if let savedPictures = defaults.object(forKey: "savedPictures") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                pictures = try jsonDecoder.decode([Picture].self, from: savedPictures)
            } catch {
                print("Failed to load data")
            }
        }
        if pictures.isEmpty {
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            for item in items{
                if item.hasPrefix("nssl"){
                    let picture = Picture(image: item, views: 0)
                    pictures.append(picture)
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let picture = pictures[indexPath.item]
        cell.textLabel?.text = picture.image
        cell.detailTextLabel?.text = "Viewed: \(picture.views)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let picture = pictures[indexPath.item]
            vc.selectedImage = picture.image
            vc.pictureSelected = indexPath.row + 1
            vc.totalPictures = pictures.count
            picture.views += 1
            save()
            tableView.reloadData()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(pictures) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "savedPictures")
        } else {
            print("Failed to save people.")
        }
    }
}

