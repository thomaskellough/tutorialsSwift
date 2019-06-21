//
//  AppDelegate.swift
//  Project 07 - Hacking With Swift
//
//  Created by Thomas Kellough on 6/19/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // App delegate window - window in which our app is running right now
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // This window is a property of the app delegate
        // Root view controller is the tab bar controller since we embedded everything in it
        // Using if let is being safe, maybe the tab bar controller won't be the root in the future?
        if let tabBarController = window?.rootViewController as? UITabBarController {
            // First, it finds Main.storyboard in our code
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // Now the nav controller can be instantiated using the identifier we gave it
            let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
            // Now we can create a new tab bar button with a unique tag
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
            // Let's now append it to the array of the tab bar controller
            tabBarController.viewControllers?.append(vc)
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

