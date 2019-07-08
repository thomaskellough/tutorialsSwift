//
//  ViewController.swift
//  Milestone Projects 19-21
//
//  Created by Thomas Kellough on 7/3/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var notes = [Note]()
    var notesIndex = 0

    
    var newNote = Note(title: "", body: "", date: "")
    var titleTextView: UITextView!
    let mainColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    let secondaryColor = UIColor(red: 235/255, green: 184/255, blue: 0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addNewNote))

        performSelector(inBackground: #selector(loadNotes), with: nil)
    
    }
    
    @objc func loadNotes() {
        let defaults = UserDefaults.standard
        if let savedNotes = defaults.object(forKey: "savedNotes") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                notes = try jsonDecoder.decode([Note].self, from: savedNotes)
            } catch {
                print("Failed to upload notes")
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        // Note: adding other tab bar icons is in AppDelegate.swift
        
        navigationController?.navigationBar.prefersLargeTitles = true
        let backButton = UIBarButtonItem()
        backButton.title = "Notes"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        navigationController?.navigationBar.topItem?.title = "Notes"
        tableView.backgroundColor = mainColor
        navigationController?.navigationBar.barTintColor = mainColor
        navigationController?.navigationBar.tintColor = secondaryColor
        navigationController?.navigationBar.clipsToBounds = true
        
        tabBarController?.tabBar.barTintColor = mainColor
        tabBarController?.tabBar.tintColor = secondaryColor
        tabBarController?.tabBar.clipsToBounds = true
        
    }
    
    func updateDate(date: String) {
        DispatchQueue.global().async {
            [weak self] in
            (self?.notes[(self?.notesIndex)!].date = date)!
        }
        self.tableView.reloadData()
    }
    
    func updateBody(body: String) {
        DispatchQueue.global().async {
            [weak self] in
            (self?.notes[(self?.notesIndex)!].body = body)!
        }
    }
    
    func updateTitle(title: String) {
        DispatchQueue.global().async {
            [weak self] in
            (self?.notes[(self?.notesIndex)!].title = title)!
        }
    }
    
    @objc func addNewNote() {
        DispatchQueue.global().async {
            [weak self] in
            let newNote = Note(title: "", body: "", date: "")
            self?.notes.insert(newNote, at: 0)
        }
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailViewController {
            vc.shareBtnVisible = true
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func deleteNote(){
        DispatchQueue.global().async {
            [weak self] in
            self?.notes.remove(at: self!.notesIndex)
            self?.save()
        }
        self.tableView.reloadData()
        self.navigationController?.popViewController(animated: true)
    }
    
//    func submit(_ note: Note) {
//        notes.insert(note, at: 0)
//
//        let indexPath = IndexPath(row: 0, section: 0)
//        tableView.insertRows(at: [indexPath], with: .automatic)
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        var bodyArr = note.body.split(separator: "\n")
        let dropIndex = 1
        let bodySlice = bodyArr.dropFirst(dropIndex)
        bodyArr = Array(bodySlice)
        var body = bodyArr.joined(separator: "\n")
        if body == ""{
            body = "No additional text"
        }
        cell.backgroundColor = mainColor
        cell.textLabel?.text = note.title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell.detailTextLabel?.text = note.date + body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = CGFloat(100)
        return cellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.item]
        notesIndex = indexPath.row
        if let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailViewController {
            vc.noteBodyText = note.body
            vc.shareBtnVisible = true
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "savedNotes")
        } else {
            print("Failed to save notes.")
        }
    }
}
