//
//  ViewController.swift
//  Project 07 - Hacking With Swift
//
//  Created by Thomas Kellough on 6/19/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    var petitionsFiltered = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterData))
        
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
//            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json" ---- cache copy in case live copy fails
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
//            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json" ---- cache copy in case live copy fails
        }

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        showError()
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed. Please check your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "This data comes from We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func filterData() {
        let ac = UIAlertController(title: "Filter with...", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let filteredBy = ac?.textFields?[0].text else { return }
            self?.submit(filteredBy)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ filteredBy: String) {
        petitionsFiltered.removeAll()
        for petition in petitions {
            let titleLower = petition.title.lowercased()
            let bodyLower = petition.body.lowercased()
            if titleLower.contains(filteredBy) || bodyLower.contains(filteredBy) {
                let title = petition.title
                let body = petition.body
                let group = [title, body]
                petitionsFiltered.append(group)
            }
        }
        tableView.reloadData()
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if petitionsFiltered.isEmpty {
            return petitions.count
        } else {
            return petitionsFiltered.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if petitionsFiltered.isEmpty {
            let petition = petitions[indexPath.row]
            cell.textLabel?.text = petition.title
            cell.detailTextLabel?.text = petition.body
        } else {
            let petition = petitionsFiltered[indexPath.row]
            cell.textLabel?.text = petition[0]
            cell.detailTextLabel?.text = petition[1]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

