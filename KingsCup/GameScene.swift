//
//  GameScene.swift
//  KingsCup
//
//  Created by Scott Crocker on 2017-03-09.
//  Copyright © 2017 Scott Crocker. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var deck : [Card] = []
    var indexCounter : Int = 51
    var label : SKMultilineLabel!
    var kingCountLabel : SKLabelNode!
    var kingCount : Int = 0
    
    override func didMove(to view: SKView) {
        let widthScale = size.width / 1080
        let heightScale = size.height / 1920
        
        playerRules = UserDefaults.standard.object(forKey: "rules") as? [String:String] ?? defaultRules
        
        let bg = SKSpriteNode(imageNamed: "tableBackground")
        
        let labelColor = UIColor(colorLiteralRed: 69.0/255, green: 55.0/255, blue: 31.0/255, alpha: 1.0)
        
        label = SKMultilineLabel(text: "", labelWidth: Int(1000 * widthScale), pos: CGPoint(x: 0, y: 0), fontName: "Avenir-Heavy", fontSize: 35, fontColor: labelColor, leading: nil, alignment: .center, shouldShowBorder: false)
        label.pos = CGPoint(x: 0, y: -(335 * heightScale))
        
        kingCountLabel = SKLabelNode(fontNamed: "Avenir-Heavy")
        kingCountLabel.fontColor = labelColor
        kingCountLabel.position = CGPoint(x: 0, y: 870 * heightScale)

        let backButton = SCButton(defaultButtonImage: "backButton", activeButtonImage: "backButton", buttonAction: goToMenu)
        backButton.setScale(0.08)
        backButton.position = CGPoint(x: -(460 * widthScale), y: 890 * heightScale)
        
        let replayButton = SCButton(defaultButtonImage: "replayGameDefault", activeButtonImage: "replayGameActive", buttonAction: playGame)
        replayButton.setScale(0.08)
        replayButton.position = CGPoint(x: 460 * widthScale, y: 890 * heightScale)
        
        addChild(bg)
        addChild(label)
        addChild(kingCountLabel)
        addChild(backButton)
        addChild(replayButton)
        
        playGame()
    }
    
    func getDeck() -> [Card] {
        var deck : [Card] = []
        for s in Card.Suit.allSuits {
            for value in 1...13 {
                deck.append(Card(suit: s, value: value))
            }
        }
        return deck
    }
    
    func goToMenu() {
        if let view = view {
            if let scene = SKScene(fileNamed: "MenuScene") {
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
        }
    }
    
    func playGame() {
        kingCount = 0
        kingCountLabel.text = "Antal kungar dragna: \(kingCount)"
        
        for card in deck {
            card.removeFromParent()
        }
        deck.removeAll()
        label.text = ""
        deck = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: getDeck()) as! [Card]
        var cardPos = CGPoint(x: 0, y: 220 * size.height / 1920)
        for card in deck {
            cardPos.y += 1
            card.defaultPos = cardPos
            card.position.y = cardPos.y
            addChild(card)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            if let card = atPoint(location) as? Card {
                if deck.index(where: { $0 == card }) == indexCounter {
                    card.isOnTop = true
                    indexCounter -= 1
                }
                if kingCount < 4 && card.isOnTop {
                    if t.tapCount > 1 {
                        card.flip()
                        label.text = playerRules["\(card.value)"]!
                        if card.value == 13 {
                            kingCount += 1
                            kingCountLabel.text = "Antal kungar dragna: \(kingCount)"
                        }
                    } else {
                        card.zPosition = 100
                        card.removeAction(forKey: "drop")
                        card.run(SKAction.scale(to: 1.1, duration: 0.1), withKey: "pickup")
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            if let card = atPoint(location) as? Card {
                if kingCount < 4 && card.isOnTop {
                    card.position = location
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            if let card = atPoint(location) as? Card {
                if kingCount < 4 && card.isOnTop {
                    card.zPosition = 10
                    card.removeFromParent()
                    addChild(card)
                    card.removeAction(forKey: "pickup")
                    if (abs(card.position.x) > (view?.frame.width)!/1.6 || abs(card.position.y) > (view?.frame.height)!/1.6) && card.faceUp {
                        let newPos = CGPoint(x: card.position.x * 3, y: card.position.y * 3)
                        self.run(SKAction.playSoundFileNamed("card_throw.wav", waitForCompletion: false))
                        card.run(SKAction.move(to: newPos, duration: 0.75), completion: {
                            card.removeFromParent()
                            if let index = self.deck.index(of: card) {
                                self.deck.remove(at: index)
                            }
                        })
                    } else {
                        card.run(SKAction.move(to: card.defaultPos, duration: 0.3))
                    }
                } else {
                    label.text = "Spelet slut! Spelaren som drog sista kortet ska dricka upp innehållet ur ert gemensamma glas!"
                }
                card.run(SKAction.scale(to: 1.0, duration: 0.1), withKey: "drop")
            }
        }
    }
}
