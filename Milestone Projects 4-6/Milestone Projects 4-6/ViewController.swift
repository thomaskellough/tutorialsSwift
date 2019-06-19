//
//  ViewController.swift
//  Milestone Projects 4-6
//
//  Created by Thomas Kellough on 6/18/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearShoppingList))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptNewItem))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        navigationItem.rightBarButtonItems = [addButton, shareButton]
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "items", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }

    @objc func promptNewItem() {
        let ac = UIAlertController(title: "Enter new grocery item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text else { return }
            self?.submit(item)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func submit(_ item: String) {
        let item = item
        shoppingList.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func clearShoppingList() {
        shoppingList.removeAll()
        self.tableView.reloadData()
    }
    
    // Added to allow user to swipe and delete each row individually
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            shoppingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    @objc func shareList() {
        let shoppingListItems = "Shopping List:\n" + shoppingList.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [shoppingListItems], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.backBarButtonItem
        present(vc, animated: true)
    }
    
}

