//
//  ViewController.swift
//  Concentration
//
//  Created by Yuzhou Cheng on 1/5/19.
//  Copyright © 2019 Yuzhou Cheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!

    lazy var numberOfPairsOfCard = (cardButtons.count + 1) / 2
    lazy var game = Concentration(numberOfPairsOfCards: self.numberOfPairsOfCard)
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resetGame()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardId = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardId) 
            updateViewFromModel()
        } else {
            print("card is not found in array")
        }
    }

    @IBAction func touchReset() {
        resetGame()
    }

    func resetGame() {
        // reset game model
        game = Concentration(numberOfPairsOfCards: self.numberOfPairsOfCard)
        // reset view states
        viewModel = ViewModel()
        view.backgroundColor = viewModel.currentCanvasColor()
        // reset view
        updateViewFromModel()
    }

    func updateViewFromModel() {
        for id in cardButtons.indices {
            let button = cardButtons[id]
            let card = game.cards[id]
            if card.isFaceUp {
                button.setTitle(viewModel.nextCardFaceIcon(for: card), for: UIControl.State.normal)
                button.backgroundColor = viewModel.currentCardFaceColor()
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatch ? #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0) : viewModel.currentCardBackColor()
            }
        }
        flipCountLabel.text = "Step:\(game.flipCount)"
        scoreLabel.text = "Score:\(game.score)"
    }
}

