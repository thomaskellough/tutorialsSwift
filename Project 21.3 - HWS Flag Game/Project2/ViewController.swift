//
//  ViewController.swift
//  Project2
//
//  Created by Thomas Kellough on 6/14/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Remind", style: .plain, target: self, action: #selector(registerLocal))
        
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
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { finished in
            sender.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
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
    
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) {
            granted, error in
            if granted {
                print("Yay!")
                self.scheduleLocal()
            } else {
                print("D'oh!")
            }
        }
    }
    
    func scheduleLocal() {
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder!"
        content.body = "Don't forget to play! Every day you do increases your knowledge of Vexillology!"
        content.categoryIdentifier = "reminder"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) -- USED FOR TESTING PURPOSES
        
        let requests = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(requests)
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let play = UNNotificationAction(identifier: "play", title: "Play now!", options: .foreground)
        let category = UNNotificationCategory(identifier: "reminder", actions: [play], intentIdentifiers: [], options: [])
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            let ac = UIAlertController(title: "Welcome Back!", message: "Thanks for opening the app from notification center!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
        case "reminder":
            let ac = UIAlertController(title: "Wanna see more?", message: "Well, I've got nothing to show you!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
        default:
            break
        }
        completionHandler()
    }
    
}
