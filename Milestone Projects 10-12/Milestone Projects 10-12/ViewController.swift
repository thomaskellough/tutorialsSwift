//
//  ViewController.swift
//  Milestone Projects 10-12
//
//  Created by Thomas Kellough on 6/26/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var images = [Image]()
    var imageToDisplay: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addNewImage))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPhoto))
        
        let defaults = UserDefaults.standard
        if let savedImages = defaults.object(forKey: "images") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                images = try jsonDecoder.decode([Image].self, from: savedImages)
            } catch {
                print("Failed to load images")
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Image", for: indexPath)
        let photo = images[indexPath.row]
        let path = getDocumentsDirectory().appendingPathComponent(photo.image)
        
        cell.textLabel?.text = photo.caption
        cell.imageView?.image = UIImage(contentsOfFile: path.path)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = images[indexPath.row]
        let path = getDocumentsDirectory().appendingPathComponent(photo.image)
        
        let ac = UIAlertController(title: "Add Caption", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Add Caption", style: .default, handler: {
            [weak self, weak ac] _ in
            guard let caption = ac?.textFields?[0].text else { return }
            photo.caption = caption
            self?.save()
            self?.tableView.reloadData()
        }))
        ac.addAction(UIAlertAction(title: "View", style: .default, handler: {
            [weak self] _ in
            if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
                vc.selectedImage = photo
                vc.path = path
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        } ))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func addNewImage() {
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func addNewPhoto() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let photo = Image(image: imageName, caption: "Enter caption...")
        images.append(photo)
        save()
        tableView.reloadData()
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(images) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "images")
        } else {
            print("Failed to save images")
        }
    }

}

