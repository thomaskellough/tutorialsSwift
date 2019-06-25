//
//  ViewController.swift
//  Project2
//
//  Created by Thomas Kellough on 6/14/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var scores = [Records]()
    var score = 0
    var correctAnswer = 0
    var totalQuestions = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareScore))
        
        let defaults = UserDefaults.standard
        if let savedHighScore = defaults.object(forKey: "savedScore") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                scores = try jsonDecoder.decode([Records].self, from: savedHighScore)
            } catch {
                print("Failed to load high score.")
            }
        }
        
        if scores.isEmpty {
            let highScore = Records(highestScore: 0)
            scores.append(highScore)
        }
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        let highScore = scores[0]
        title = "\(countries[correctAnswer].uppercased()) - Score: \(score) Highest: \(highScore.highestScore)"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String?
        
        if sender.tag == correctAnswer {
            title = "Correct!"
            score += 1
        } else {
            title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        totalQuestions += 1
        
        if totalQuestions == 10 {
            let highScore = scores[0]
            if score > highScore.highestScore {
                highScore.highestScore = score
                save()
            }
            let ac = UIAlertController(title: "Game Over!", message: "This game: \(score) Highest: \(highScore.highestScore)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Quit", style: .default, handler: askQuestion))
            present(ac, animated: true)
            totalQuestions = 0
            score = 0
        } else {
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
        
    }
    
    @objc func shareScore() {
        let highScore = scores[0]
        let textToShare = "My highest score is \(highScore.highestScore)! Can you beat me?"
        let appLink = "www.placelinktoapphere.com"
        let objectToShare = [textToShare, appLink]
        
        let vc = UIActivityViewController(activityItems: objectToShare, applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.backBarButtonItem
        present(vc, animated: true)
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(scores) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "savedScore")
        } else {
            print("Failed to save high score.")
        }
    }
}
