//
//  ViewController.swift
//  Milestone Projects 7-9
//
//  Created by Thomas Kellough on 6/21/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    @IBOutlet weak var buttonE: UIButton!
    @IBOutlet weak var buttonF: UIButton!
    @IBOutlet weak var buttonG: UIButton!
    @IBOutlet weak var buttonH: UIButton!
    @IBOutlet weak var buttonI: UIButton!
    @IBOutlet weak var buttonJ: UIButton!
    @IBOutlet weak var buttonK: UIButton!
    @IBOutlet weak var buttonL: UIButton!
    @IBOutlet weak var buttonM: UIButton!
    @IBOutlet weak var buttonN: UIButton!
    @IBOutlet weak var buttonO: UIButton!
    @IBOutlet weak var buttonP: UIButton!
    @IBOutlet weak var buttonQ: UIButton!
    @IBOutlet weak var buttonR: UIButton!
    @IBOutlet weak var buttonS: UIButton!
    @IBOutlet weak var buttonT: UIButton!
    @IBOutlet weak var buttonU: UIButton!
    @IBOutlet weak var buttonV: UIButton!
    @IBOutlet weak var buttonW: UIButton!
    @IBOutlet weak var buttonX: UIButton!
    @IBOutlet weak var buttonY: UIButton!
    @IBOutlet weak var buttonZ: UIButton!
    
    
    var imageList = ["hangman0", "hangman1", "hangman2", "hangman3", "hangman4", "hangman5", "hangman6"]
    var hangmanImageIndex = 0
    var usedWords = [String]()
    var correctWord = String()
    var newWord = String()
    var usedLetters = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .redo, target: self, action: #selector(loadGame))
        if let backgroundImage = UIImage(named: "hangmanBackground.png") {
            view.backgroundColor = UIColor(patternImage: backgroundImage)
        }
        
        loadGame()
    }

    func resetImage() {
        hangmanImage.image = UIImage(named: "hangman0")
    }
    
    func obtainNewWord() {
        var category = ""
        var word = ""
        var wordSpaces = ""
        if let wordFileURL = Bundle.main.url(forResource: "hangmanWords", withExtension: "txt") {
            if let wordsContents = try? String(contentsOf: wordFileURL) {
                var lines = wordsContents.components(separatedBy: "\n")
                lines.shuffle()
                
                let parts = lines[0].components(separatedBy: ": ")
                category = parts[0]
                word = parts[1]
                correctWord = word.uppercased()
                usedWords.append(lines[0])
            }
        }
        
        usedLetters.removeAll()
        for _ in word {
            wordSpaces += "?"
        }
        
        categoryLabel.text = category
        wordLabel.text = wordSpaces
        newWord = correctWord
    }
    
    func resetButtons() {
        let buttonList = [buttonA, buttonB, buttonC, buttonD, buttonE, buttonF, buttonG, buttonH, buttonI, buttonJ, buttonK, buttonL, buttonM, buttonN, buttonO,
                          buttonP, buttonQ, buttonR, buttonS, buttonT, buttonU, buttonV, buttonW, buttonX, buttonY, buttonZ]
        for button in buttonList {
            button?.layer.borderWidth = 1
            button?.layer.borderColor = UIColor.lightGray.cgColor
            button?.layer.backgroundColor = UIColor.white.cgColor
            button?.layer.cornerRadius = 5
            button?.isEnabled = true
        }
    }

    @objc func loadGame() {
        hangmanImageIndex = 0
        
        resetImage()
        resetButtons()
        obtainNewWord()
    }
    
    @objc func startOver() {
        loadGame()
    }
    
    func correctButtonClicked(btn: UIButton) {
        btn.backgroundColor = .green
        btn.isEnabled = false
    }
    
    func incorrectButtonClicked(btn: UIButton) {
        btn.backgroundColor = .red
        btn.isEnabled = false
    }
    
    func disableAllButtons(btn: UIButton) {
        let buttonList = [buttonA, buttonB, buttonC, buttonD, buttonE, buttonF, buttonG, buttonH, buttonI, buttonJ, buttonK, buttonL, buttonM, buttonN, buttonO,
                          buttonP, buttonQ, buttonR, buttonS, buttonT, buttonU, buttonV, buttonW, buttonX, buttonY, buttonZ]
        for button in buttonList {
            button?.isEnabled = false
        }
    }
    

    @IBAction func letterTapped(_ sender: UIButton) {
        guard let buttonLetter = sender.titleLabel?.text else { return }
        var newWord = ""
        
        // If user guesses correct letter, create a new word label for the UI and disable the button
        if correctWord.contains(buttonLetter) {
            usedLetters.append(buttonLetter)
            
            for char in correctWord {
                if usedLetters.contains(String(char)) {
                    newWord += String(char)
                } else {
                    newWord += "?"
                }
            }
            
            correctButtonClicked(btn: sender)
            wordLabel.text = newWord
            
            // If user completes the full word alert then and return while disabling all buttons
            if newWord == correctWord {
                let ac = UIAlertController(title: "Game Over!", message: "Great job! You won!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                present(ac, animated: true)
                disableAllButtons(btn: sender)
                return
            }
        } else {
            // If user guesess incorrect letter, update hangman image and disable button
            // If hangman image is the last one, alert loser they lost and disable all buttons
            hangmanImageIndex += 1
            hangmanImage.image = UIImage(named: imageList[hangmanImageIndex])
            if hangmanImageIndex == 6 {
                wordLabel.text = correctWord
                let ac = UIAlertController(title: "Game Over!", message: "Sorry, you lost!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                present(ac, animated: true)
                incorrectButtonClicked(btn: sender)
                disableAllButtons(btn: sender)
            } else {
                newWord = wordLabel.text!
                incorrectButtonClicked(btn: sender)
                wordLabel.text = newWord
            }
        }
    }

}

