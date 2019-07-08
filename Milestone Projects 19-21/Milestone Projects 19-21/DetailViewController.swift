//
//  DetailViewController.swift
//  Milestone Projects 19-21
//
//  Created by Thomas Kellough on 7/3/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var noteBody: UITextView!
    var noteBodyText = ""
    weak var delegate: ViewController!
    var shareBtnVisible = false
    var saveBtnVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        noteBody.text = noteBodyText
        NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        navigationController?.navigationBar.prefersLargeTitles = false
       
        let shareBtn = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareNote))
        let deleteBtn = UIBarButtonItem(barButtonSystemItem: .trash, target: delegate, action: #selector(delegate.deleteNote))
        let saveBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveNote))
        
        if shareBtnVisible {
            navigationItem.rightBarButtonItems = [shareBtn, deleteBtn]
        } else {
            navigationItem.rightBarButtonItems = [saveBtn, shareBtn, deleteBtn]
        }
        
        self.noteBody.backgroundColor = delegate.mainColor

        
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        shareBtnVisible = false
        self.viewDidLoad()
    }
    
    @objc func shareNote() {
        let textToShare = noteBody.text
        let objToShare = [textToShare]
        let vc = UIActivityViewController(activityItems: objToShare as [Any], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.backBarButtonItem
        present(vc, animated: true)
    }
    
    func getDate() -> String {
        let date = Date()
        let format = DateFormatter()
        format.locale = Locale(identifier: "en_US")
        format.dateStyle = .short
        let formattedDate = format.string(from: date) + "\t"
        return formattedDate
    }
    
    @objc func saveNote() {
        noteBodyText = noteBody.text
        let noteBodyArr = noteBodyText.split(separator: "\n")
        let titleSubstring = noteBodyArr[0]
        let title = String(titleSubstring)
        delegate.updateTitle(title: title)
        delegate.updateBody(body: noteBodyText)
        delegate.updateDate(date: getDate())
        delegate.save()
        self.view.endEditing(true)
        shareBtnVisible = true
        self.viewDidLoad()
    }
}
