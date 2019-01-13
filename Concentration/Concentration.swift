//
//  Concentration.swift
//  Concentration
//
//  Created by Yuzhou Cheng on 1/7/19.
//  Copyright © 2019 Yuzhou Cheng. All rights reserved.
//

import Foundation


class Concentration {
    var cards = [Card]()
    var chosenCardRecord: [Int: Date] = [:]
    var indexOfFaceUpCard: Int?
    var flipCount = 0
    var score = 0

    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }

    func reward(for card: Card) -> Int {
        // base point for scoring a match is 2 points
        let baseReward = 2
        let cardMatchTime = Date()
        let timeToMatchCard = cardMatchTime.timeIntervalSince(chosenCardRecord[card.identifier]!)
        /* score multiplier is calculated based on elapsed time
         * between first flip time for the card with identifier X
         * and match finding time for 2 cards with identifier X.
         *     Time elapsed -> multiplier list is showed below:
         *                 time <= 5 sec -> 3x multiplier
         *         5sec  < time <= 10sec -> 2x multiplier
         *         10sec < time          -> 1x multiplier
         */
        var multiplier = 1
        if timeToMatchCard <= 5.0 {
            multiplier *= 3
        } else if timeToMatchCard <= 10.0 {
            multiplier *= 2
        }
        return baseReward * multiplier
    }

    func penalty(for card: Card) -> Int {
        if chosenCardRecord[card.identifier] != nil {
            // mismatch penalty will not be speed adjusted
            return 1
        }
        // add selected card to record and
        // record first selection timestamp
        chosenCardRecord[card.identifier] = Date()
        return 0
    }

    func chooseCard(at index: Int) {
        if !cards[index].isMatch {
            if let matchIndex = indexOfFaceUpCard, matchIndex != index {
                // one card face up, need to do comparison
                if cards[matchIndex].identifier == cards[index].identifier {
                    score += reward(for: cards[index])
                    cards[matchIndex].isMatch = true
                    cards[index].isMatch = true
                } else {
                    // 2 cards face up and mismatch
                    score -= (penalty(for: cards[index]) +
                              penalty(for: cards[matchIndex]))
                }
                cards[index].isFaceUp = true
                indexOfFaceUpCard = nil
            } else {
                // no card or 2 cards face up, no need for comparison
                if chosenCardRecord[cards[index].identifier] == nil {
                    // record first touch time of a card
                    chosenCardRecord[cards[index].identifier] = Date()
                }
                for id in cards.indices {
                    cards[id].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfFaceUpCard = index
            }
            flipCount += 1
        }
    }
}
