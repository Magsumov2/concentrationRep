//  ViewController.swift
//  Concentration
//
//  Created by CS193p Instructor  on 09/25/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)

    
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributes : [NSAttributedString.Key:Any]=[
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let  attributedString = NSAttributedString(string:"Новая Игра", attributes: attributes)
        newGameButton.setAttributedTitle(attributedString, for: UIControl.State.normal)
        let  attributedString2 = NSAttributedString(string:"игра окончена", attributes: attributes)
        newGameButton.setAttributedTitle(attributedString2, for: UIControl.State.highlighted)
        
    }
    
    
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0.4894246471, green: 0.6811027336, blue: 1, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)",
            attributes: attributes)
        
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet weak var newGameButton: UIButton!
    
    
    @IBAction func newGameSeted(_ sender: UIButton) {
        game.score = 0
        flipCount = 0
        game.cardsReset()
        updateViewFromModel()
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{
            updateFlipCountLabel()
        }
    }
    
    
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("choosen card was not in cardButtons")
        }
    }
    let array = [Int]()
    
    
    private func updateViewFromModel() {
        if cardButtons != nil{
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji (for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                } else {
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0.4894246471, green: 0.6811027336, blue: 1, alpha: 1)
                }
            }
        }
        
    }
    var theme:String? {
        didSet{
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    private var emojiChoices = "🦇😱🙀😈🎃👻🍭🍬🍎"
    
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let stringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: stringIndex))
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self))) }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}














