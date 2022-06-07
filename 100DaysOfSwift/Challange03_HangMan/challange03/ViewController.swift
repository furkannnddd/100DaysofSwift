//
//  ViewController.swift
//  challange03
//
//  Created by Furkan DURSUN on 11.04.2022.
//

import UIKit

class ViewController: UIViewController {
    var titleLabel: UILabel!
    var scoreLabel: UILabel!
    var wrongAnswerLabel: UILabel!
    var answerLabel: UILabel!
    
    var alphabet = ["Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M", "☠️"]
    var letterButtons = [UIButton]()
    var tappedButtons = [UIButton]()
    
    var guessedLetters = 0
    var attemptsLeft = 0
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var errorScore = 0 {
        didSet {
            wrongAnswerLabel.text = "Wrong answers: \(errorScore) of 6 ☠️"
        }
    }
    
    var word = ""
    var usedLetters = [Character]()
    var promptWord = [String]()
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.font = UIFont.systemFont(ofSize: 24)
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        wrongAnswerLabel = UILabel()
        wrongAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
        wrongAnswerLabel.textAlignment = .right
        wrongAnswerLabel.font = UIFont.systemFont(ofSize: 24)
        wrongAnswerLabel.text = "Wrong answers: \(errorScore) of 6 ☠️"
        view.addSubview(wrongAnswerLabel)
    
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .right
        titleLabel.font = UIFont.systemFont(ofSize: 55)
        titleLabel.text = "☠️ H A N G M A N ☠️"
        view.addSubview(titleLabel)
        
        answerLabel = UILabel()
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.textAlignment = .center
        answerLabel.text = "ANSWER"
        answerLabel.font = UIFont.systemFont(ofSize: 44)
        view.addSubview(answerLabel)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("NEW WORD", for: .normal)
        submit.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        submit.addTarget(self, action: #selector(newGameTapped), for: .touchUpInside)
        view.addSubview(submit)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 150),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            wrongAnswerLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 150),
            wrongAnswerLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: scoreLabel.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            answerLabel.topAnchor.constraint(equalTo: scoreLabel.topAnchor, constant: 200),
            answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            submit.topAnchor.constraint(equalTo: answerLabel.topAnchor, constant: 150),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submit.heightAnchor.constraint(equalToConstant: 44),
            
            buttonsView.widthAnchor.constraint(equalToConstant: 900),
            buttonsView.heightAnchor.constraint(equalToConstant: 270),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
            ])
        
        let width = 100
        let height = 100
        
        for row in 0..<3 {
            for column in 0..<9 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("W", for: .normal)
                letterButton.layer.borderWidth = 1
                letterButton.layer.borderColor = UIColor.lightGray.cgColor
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
        for (index, button) in letterButtons.enumerated() {
            button.setTitle(alphabet[index], for: .normal)
        }
    }

    @objc func newGameTapped(_ sender: UIButton) {
        newGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLevel()
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        tappedButtons.append(sender)
        sender.isHidden = true
        sender.isUserInteractionEnabled = false
        guard let buttonTitle = sender.titleLabel?.text?.lowercased() else {return}
        
        if usedLetters.contains(Character(buttonTitle)) {
            for (index, character) in usedLetters.enumerated() {
                if character == Character(buttonTitle) {
                    promptWord[index] = buttonTitle
                    answerLabel.text = promptWord.joined().uppercased()
                    guessedLetters += 1
                    score += 1
                
                    if guessedLetters == word.count {
                        let ac = UIAlertController(title: "CONGRATULATIONS!", message: "You survived!", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "Move on!", style: .default, handler: newGame))
                        present(ac, animated: true)
                    }
                }
        }
    } else {
            errorScore += 1
            if errorScore <= 5 {
                let ac = UIAlertController(title: "WRONG", message: "Choose another letter!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true, completion: nil)
            } else {
                let ac = UIAlertController(title: "GAME OVER", message: "You are dead!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Try again", style: .default, handler: newGame))
                present(ac, animated: true)
                score = 0
                errorScore = 0
            }
        }
    }

    
    @objc func loadLevel() {
        if let wordListURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let wordListContent = try? String(contentsOf: wordListURL) {
                var words = wordListContent.components(separatedBy: "\n")
                words.shuffle()
                
                word = words.randomElement()!
                print("Word: \(word)")
                
                for letter in word {
                    usedLetters.append(letter)
                    promptWord.append("?")
                }
                print("Used letters: \(usedLetters)")
                print("Prompt word: \(promptWord)")
                
                answerLabel.text = promptWord.joined()
            }
        }


}
    
    @objc func newGame(action: UIAlertAction! = nil) {
        word = ""
        promptWord.removeAll()
        usedLetters.removeAll()
        guessedLetters = 0
        for button in tappedButtons {
            button.isHidden = false
            button.isUserInteractionEnabled = true
        }
        errorScore = 0
        loadLevel()
    }

}
