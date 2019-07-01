//
//  DetailViewController.swift
//  Milestone Projects 13-15
//
//  Created by Thomas Kellough on 6/30/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    var detailItem: Country?
    var countryName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = countryName
        navigationController?.navigationBar.prefersLargeTitles = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareFacts))
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "country")
        let cell = tableView.dequeueReusableCell(withIdentifier: "country", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Capital: \(String(describing: detailItem!.capital!))"
        case 1:
            cell.textLabel?.text = "Official Language: \(String(describing: detailItem!.languages[0]["official"]!))"
        case 2:
            cell.textLabel?.text = "Secondary Language: \(String(describing: detailItem!.languages[0]["second"]!))"
        case 3:
            cell.textLabel?.text = "Area (sq mi): \(String(describing: detailItem!.area))"
        case 4:
            cell.textLabel?.text = "Population: \(String(describing: detailItem!.population))"
        case 5:
            cell.textLabel?.text = "Population increasing? \(String(describing: detailItem!.populationIncreasing))"
        case 6:
            cell.textLabel?.text = "Currency: \(detailItem!.currency)"
        default:
            cell.textLabel?.text = nil
        }
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    @objc func shareFacts() {
        var nameShare: String?
        var populationShare: String?
        var officialLanguageShare: String?
        var secondaryLanguageShare: String?
        var areaShare: String?
        var capitalShare: String?
        var currencyShare: String?
        
        if let name = detailItem?.country {
            nameShare = "\(name) is a fascinating country!"
        }
        if let population = detailItem?.population {
            populationShare = "It has a population of \(population)!"
        }
        if let officialLanguage = detailItem?.languages[0]["official"] {
            officialLanguageShare = "The offical language is \(officialLanguage)."
        }
        if let secondaryLanguage = detailItem?.languages[0]["second"] {
            secondaryLanguageShare = "\(secondaryLanguage) is the second most common language."
        }
        if let area = detailItem?.area {
            areaShare = "Belive it or not, the total amount of land covers \(area) square miles!"
        }
        if let capital = detailItem?.capital {
            capitalShare = "If you didn't know, the capital of this beautiful country is \(capital)"
        }
        if let currency = detailItem?.currency {
            currencyShare = "If you ever go there, make sure you have some \(currency)s on you, since that's the curency they use!"
        }
        
        let objToShare = [nameShare, populationShare, officialLanguageShare, secondaryLanguageShare, areaShare, capitalShare, currencyShare ]
        let vc = UIActivityViewController(activityItems: objToShare as [Any], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.backBarButtonItem
        present(vc, animated: true)
    }

}
