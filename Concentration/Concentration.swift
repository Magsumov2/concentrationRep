//
//  Concentration.swift
//
//  Created by CS193p Instructor  on 09/25/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import Foundation

struct Concentration {
    
	
	private(set) var cards = [Card]()
    var score = 0
	private var indexOfOneAndOnlyFaceUpCard: Int? {
		get {
           return cards.indices.filter{ cards[$0].isFaceUp}.theOneAndOnly
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp  {
//                    guard foundIndex == nil else { return nil }
//                    foundIndex = index
//                }
//            }
//            return foundIndex
		}
		set(newValue) {
			for index in cards.indices {
				cards[index].isFaceUp = (index == newValue)
			}
		}
				
	}
    mutating func cardsReset(){
        for index in cards.indices{
            cards[index].isFaceUp = false
            cards[index].isMatched = false 
        }
        cards.shuffle()
    
    }
	
    
    mutating func chooseCard(at index: Int) {
		assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : Choosen index out of range")
		if !cards[index].isMatched {
			if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
				// check if cards match
				if cards[matchIndex] == cards[index]{
					cards[matchIndex].isMatched = true
					cards[index].isMatched = true
             
				}
				cards[index].isFaceUp = true
			} else {
				indexOfOneAndOnlyFaceUpCard = index
			}
		}
	}
	
	init(numberOfPairsOfCards: Int) {
		assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)) : You must have at least one pair of cards")
		for _ in 1...numberOfPairsOfCards {
			let card = Card()
			cards += [card, card]
		}
        cards.shuffle()
	
	}
}
extension Array {
    /// тасование элементов  `self` "по месту".
    mutating func shuffle() {
        if count < 2 { return }
        for i in indices.dropLast() {
            let diff = distance(from: i, to: endIndex)
            let j = index(i, offsetBy: diff.arc4random)
            swapAt(i, j)
        }
    }
}


extension Collection{
    var theOneAndOnly:Element?{
        return count == 1 ? first : nil
    }
}


