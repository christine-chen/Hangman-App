//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var hangmanImageView: UIImageView!
    @IBOutlet var wordToGuessLabel: UILabel!
    
    var numberOfWrongGuesses = 0
    var phraseArray = [Character]()
    var correctGuessArray = [Character]()
    var dashesAndSpaces = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        
        hangmanImageView.image = UIImage(named: "hangman1.gif")
        
        for letter in phrase.characters {
            phraseArray.append(letter)
            if (letter == " ") {
                dashesAndSpaces += " "
            }
            dashesAndSpaces += "-"
        }
        wordToGuessLabel.text = dashesAndSpaces
        print(phrase)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func letterGuess(button: UIButton?) {
        var counter = 0
        while phraseArray.count > counter {
            if String(phraseArray[counter]) == button!.titleLabel!.text {
                correctGuessArray[counter] = phraseArray[counter]
            }
            counter += 1
        }
    }
    
    func hangmanImage() {
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
        } else {
            hangmanImageView.image = UIImage(named: "hangman7.gif")
        }
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
