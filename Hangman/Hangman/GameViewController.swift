//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var wordToGuessLabel: UILabel!
    @IBOutlet var incorrectLettersLabel: UILabel!
    @IBOutlet var hangmanImageView: UIImageView!
    @IBOutlet var topStackView: UIStackView!
    @IBOutlet var middleStackView: UIStackView!
    @IBOutlet var bottomStackView: UIStackView!
    
    var numberOfWrongGuesses = 0
    var phraseArray = [Character]()
    var correctGuessArray = [Character]()
    var incorrectLettersArray = [Character]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        
        numberOfWrongGuesses = 0
        phraseArray.removeAll()
        correctGuessArray.removeAll()
        incorrectLettersArray.removeAll()
        incorrectLettersLabel.text = ""
        
        for t in topStackView.subviews {
            t.alpha = 1
        }
        for m in middleStackView.subviews {
            m.alpha = 1
        }
        for b in bottomStackView.subviews {
            b.alpha = 1
        }
        
        hangmanImageView.image = UIImage(named: "hangman1.gif")
        
        for letter in phrase.characters {
            phraseArray.append(letter)
            if (letter == " ") {
                correctGuessArray.append(" ")
            } else {
                correctGuessArray.append("-")
            }
        }
        
        wordToGuessLabel.text = String(correctGuessArray)
        print(phrase)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startOver(sender: UIButton) {
        self.viewDidLoad()
    }
    
    @IBAction func letterGuess(sender: UIButton) {
        var counter = 0
        sender.alpha = 0
        print(sender.titleLabel!.text)
        while phraseArray.count > counter {
            if String(phraseArray[counter]) == sender.titleLabel!.text {
                correctGuessArray[counter] = phraseArray[counter]
                wordToGuessLabel.text = String(correctGuessArray)
            }
            if !correctGuessArray.contains("-") && numberOfWrongGuesses < 6 {
                let alertWin = UIAlertController(title: "You Win!",message: "Congratulations!",preferredStyle: .Alert)
                alertWin.addAction(UIAlertAction(title: "New Game", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in self.refreshView()}))
                self.presentViewController(alertWin, animated: true, completion: nil)
            }
            counter += 1
        }
        if !phraseArray.contains(Character(sender.titleLabel!.text!)) && !incorrectLettersArray.contains(Character(sender.titleLabel!.text!)) {
            numberOfWrongGuesses += 1
            incorrectLettersArray.append(Character(sender.titleLabel!.text!))
            incorrectLettersArray.append(",")
            incorrectLettersArray.append(" ")
            incorrectLettersLabel.text = "Incorrect Letters: " + String(incorrectLettersArray)
        }
        changeHangmanImageView()

        if hangmanImageView.image == UIImage(named: "hangman7.gif") {
            let alertLose = UIAlertController(title: "You Lose!",message: "Better luck next time.",preferredStyle: .Alert)
            alertLose.addAction(UIAlertAction(title: "Play Again?", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in self.refreshView()}))
            self.presentViewController(alertLose, animated: true, completion: nil)
        }
    }

    func changeHangmanImageView() {
        if numberOfWrongGuesses == 1 {
            hangmanImageView.image = UIImage(named: "hangman2.gif")
        } else if numberOfWrongGuesses == 2 {
            hangmanImageView.image = UIImage(named: "hangman3.gif")
        } else if numberOfWrongGuesses == 3 {
            hangmanImageView.image = UIImage(named: "hangman4.gif")
        } else if numberOfWrongGuesses == 4 {
            hangmanImageView.image = UIImage(named: "hangman5.gif")
        } else if numberOfWrongGuesses == 5 {
            hangmanImageView.image = UIImage(named: "hangman6.gif")
        } else if numberOfWrongGuesses == 6 {
            hangmanImageView.image = UIImage(named: "hangman7.gif")
        }
    }
    
    func refreshView() ->() {
        
        // Calling the viewDidLoad and viewWillAppear methods to "refresh" the VC and run through the code within the methods themselves
        self.viewDidLoad()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
