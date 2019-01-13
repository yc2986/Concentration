//
//  ViewModel.swift
//  Concentration
//
//  Created by Yuzhou Cheng on 1/9/19.
//  Copyright © 2019 Yuzhou Cheng. All rights reserved.
//

import Foundation
import UIKit

class ViewModel {
    typealias theme = [(cardFaceColor: UIColor, cardBackColor: UIColor, canvasColor: UIColor, cardFaceIcon: [String])]

    static let maxCardFace = 8
    var themes = [
        // halloween theme
        (cardFaceColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), cardBackColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), canvasColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
         cardFaceIcon: ["🎃", "👻", "👿", "😇", "👼🏻", "🦎", "🐲", "🐙"]),
        // ball game theme
        (cardFaceColor: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),cardBackColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), canvasColor: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1),
         cardFaceIcon: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🎱", "🏏", "🏓"]),
        // vehicle theme
        (cardFaceColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), cardBackColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), canvasColor: #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1),
         cardFaceIcon: ["🏎", "🚔", "🏍", "🚲", "🚎", "🚈", "✈️", "🚀"])
    ]
    
    var cardFaceIndex = 0
    var themeIndex = 0
    var selectedCardFaceDict = Dictionary<Int, String>()

    init() {
        // shuffle card face icon
        themes[themeIndex].cardFaceIcon.shuffle()
        // reset card face index
        cardFaceIndex = 0
        // shuffle theme index
        themeIndex = Int(arc4random_uniform(UInt32(themes.count)))
    }

    func nextCardFaceIcon(for card: Card) -> String {
        if selectedCardFaceDict[card.identifier] == nil, cardFaceIndex < ViewModel.maxCardFace {
            selectedCardFaceDict[card.identifier] = themes[themeIndex].cardFaceIcon[cardFaceIndex];
            cardFaceIndex += 1
        }
        return selectedCardFaceDict[card.identifier] ?? "?"
    }

    func currentCardFaceColor() -> UIColor {
        return themes[themeIndex].cardFaceColor
    }
    
    func currentCardBackColor() -> UIColor {
        return themes[themeIndex].cardBackColor
    }
    
    func currentCanvasColor() -> UIColor {
        return themes[themeIndex].canvasColor
    }
}
