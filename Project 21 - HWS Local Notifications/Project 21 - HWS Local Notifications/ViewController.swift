//
//  ViewController.swift
//  Project 21 - HWS Local Notifications
//
//  Created by Thomas Kellough on 7/3/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UserNotifications
import UIKit

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }

    @objc func registerLocal() {
        //  Request permission to show user notifications
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) {
            granted, error in
            if granted {
                print("Yay!")
            } else {
                print("D'oh!")
            }
        }
    }
    
    @objc func scheduleLocal() {
        registerCateories()
        //  Run if we have user permission from registerLocal()
        //  What content to show
        //  When to show it
        //  A request (combination of content and timing)
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()  //  Remove all pending notification requests
        
        //  Content to show
        let content = UNMutableNotificationContent()
        content.title = "Late wakeup call"  //  Bigger text on notification, couple words at most, ideally
        content.body = "The early bird catches the worm, but the second mouse gets the cheese" //  Main message
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .default
        
        //  When to show it
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)  // Good for testing purposes!
        
        //  Request
        let requests = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(requests)
        
     }
    
    func registerCateories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self  //  Any messages get sent back to us
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more", options: .foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [], options: [])
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom Data received: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                //  The user swiped to unlock
                print("Default identifier")
                
            case "show":
                //  User tapped our custom button with the "show" identifier (made in registerCategories())
                print("Show more information")
                
            default:
                break
            }
        }
        //  We must call the completion handler when we are finished
        completionHandler()  //  Remember, this is marked as @escaping, so it can escape the current method and be used later on
    }

}

