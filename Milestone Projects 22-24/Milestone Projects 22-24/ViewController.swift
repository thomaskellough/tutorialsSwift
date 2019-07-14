//
//  ViewController.swift
//  Milestone Projects 22-24
//
//  Created by Thomas Kellough on 7/13/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//


// Challenge 1:
// Extend UIView so that it has a bounceOut(duration:) method that uses animation to
// scale its size down to 0.0001 over a specified number of seconds.

// Challenge 2:
// Extend Int with a times() method that runs a closure as many times as the number is high.
// For example, 5.times { print("Hello!") } will print “Hello” five times.

// Challenge 3:
// Extend Array so that it has a mutating remove(item:) method.
// If the item exists more than once, it should remove only the first instance it finds.
// Tip: you will need to add the Comparable constraint to make this work!

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = UIColor.red

        let scaleBtn = UIBarButtonItem(title: "Scale", style: .plain, target: self, action: #selector(scaleDown))
        let repeatBtn = UIBarButtonItem(title: "Repeat", style: .plain, target: self, action: #selector(repeatMe))
        let removeBtn = UIBarButtonItem(title: "Remove", style: .plain, target: self, action: #selector(removeItem))
        
        navigationItem.rightBarButtonItems = [removeBtn, repeatBtn, scaleBtn]
        
    }
    
    // Challenge 1
    @objc func scaleDown() {
        mainView.bounceOut(duration: 4)
    }
    
    // Challenge 2
    @objc func repeatMe() {
        5.times { print("Hello!") }
    }
    
    // Challenge 3
    @objc func removeItem() {
        var animals = ["cat", "dog", "horse", "pig"]
        print(animals)
        animals.remove(item: "pig")
        print(animals)
        
    }
}

// Challenge 1
extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
    }
}

// Challenge 2
extension Int {
    func times(performClosure: () -> Void) {
        guard self > 0 else { return }
        for _ in 1...self {
            performClosure()
        }
    }
}

// Challenge 3
extension Array where Element: Comparable {
   mutating func remove(item: Element) {
        if let itemIndex = self.firstIndex(of: item) {
            self.remove(at: itemIndex)
        }
    }
}

