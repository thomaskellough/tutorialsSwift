//
//  ViewController.swift
//  Project 28 - HWS Secret Swift
//
//  Created by Thomas Kellough on 7/20/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import LocalAuthentication  // gives us access to touch/face ID
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var secret: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Nothing to see here"
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)  // call saveSecretMessage when user leaves the app
        
        // TODO - allow user to set a password
        KeychainWrapper.standard.set("password", forKey: "SecretPassword")
    }

    @IBAction func authenticateTapped(_ sender: Any) {
        let context = LAContext()  // LA short for LocalAuthentication
        var error: NSError?  // objc form of Swift error type
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)   {  // don't pass in error itself, but where it is in RAM, pointer
            let reason = "Identify yourself!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self?.unlockedSecretMessage()
                    } else {
                        // error
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again or select OK to enter the password", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: self?.passwordEntered))
                        self?.present(ac, animated: true)
                    }
                }
            }
        } else {
            // no biometry
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.\n Would you like to enter the password?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: passwordEntered))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
            
        }
        
    }
    
    func passwordEntered(alert: UIAlertAction!) {
        let ac = UIAlertController(title: "Please enter the secret password", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitPassword = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let password = ac?.textFields?[0].text else { return }

            if password ==  KeychainWrapper.standard.string(forKey: "SecretPassword") {
                self?.unlockedSecretMessage()
            } else {
                let failedAC = UIAlertController(title: "Wrong password!", message: nil, preferredStyle: .alert)
                failedAC.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(failedAC, animated: true)
            }
        }
        ac.addAction(submitPassword)
        present(ac, animated: true)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEnd = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEnd, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            secret.contentInset = .zero
        } else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        secret.scrollIndicatorInsets = secret.contentInset
        
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
    }
    
    func unlockedSecretMessage() {
        secret.isHidden = false
        title = "Secret stuff!"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveSecretMessage))
        
        secret.text = KeychainWrapper.standard.string(forKey: "SecretMessage") ?? ""
    }
    
    @objc func saveSecretMessage() {
        guard secret.isHidden == false else { return }
        navigationItem.rightBarButtonItem = nil
        
        KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
        secret.resignFirstResponder()  // make the text view stop being active on the screen right now
        secret.isHidden = true
        title = "Nothing to see here"
    }
    
}

