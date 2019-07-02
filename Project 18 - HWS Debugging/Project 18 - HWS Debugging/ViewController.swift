//
//  ViewController.swift
//  Project 18 - HWS Debugging
//
//  Created by Thomas Kellough on 7/1/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("I'm inside the viewDidLoad() method")
        print(1, 2, 3, 4, 5)
        print(1, 2, 3, 4, 5, separator: "-")
        print("Some message", terminator: "")
        
        
        
        // assert ONLY executes while in test build, they are removed after going to the app store and being shipped out
//        assert(1 == 1, "Math failure!")
//        assert(1 == 2, "Math failure!")
//        assert(myReallySlowMethod() == true, "The slow method returned false, which is a bad thing")
        
        
        // Add a break point on the print statement
        // Press f6 to cycle through line by line in the for loops (look bottom left)
        // Press ctrl+cmd+y to run code until it hits another break point
        // Next to lldb in the console, you can type "p i" to print the next number
        // You can also move the green "Thread 1: breakpoint 1.1" up and run the code from somewhere else!
        // cmd + . will stop you program
        
        // Breakpoints can also be conditional! Right click break point and click edit breakpoint
        // Then type: i % 10 == 0
        
        for i in 1...100 {
            print("Got number: \(i)")
        }
        
    }


}

