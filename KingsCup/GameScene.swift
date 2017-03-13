//
//  GameScene.swift
//  KingsCup
//
//  Created by Scott Crocker on 2017-03-09.
//  Copyright © 2017 Scott Crocker. All rights reserved.
//

import SpriteKit
import GameplayKit

enum CardLevel : CGFloat {
    case board = 10
    case moving = 100
}

func getDeck() -> [Card] {
    var deck : [Card] = []
    for s in Suit.allSuits {
        for value in 1...13 {
            deck.append(Card(suit: s, value: value))
        }
    }
    return deck
}

var deck : [Card] = []
var label : SKMultilineLabel = SKMultilineLabel(text: "", labelWidth: 100, pos: CGPoint(x: 0, y: 0), fontName: "Avenir-Heavy", fontSize: 35, fontColor: UIColor.black, leading: nil, alignment: .center, shouldShowBorder: false)

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        let bg = SKSpriteNode(imageNamed: "tableBackground")
        addChild(bg)
        
        deck = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: getDeck()) as! [Card]
        
        var cardPos = CGPoint(x: 0, y: 150)
        
        for card in deck {
            cardPos.y += 1
            card.defaultPos = cardPos
            card.position.y = cardPos.y
            addChild(card)
        }

        label.labelWidth = Int(view.frame.width*2)
        label.pos = CGPoint(x: 0, y: -(view.frame.height/2))
        addChild(label)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            if let card = atPoint(location) as? Card {
                card.zPosition = CardLevel.moving.rawValue
                card.removeAction(forKey: "drop")
                card.run(SKAction.scale(to: 1.1, duration: 0.1), withKey: "pickup")
                if t.tapCount > 1 {
                    card.flip()
                    label.text = defaultRules[card.value]!
                    label.alpha = 1.0
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            if let card = atPoint(location) as? Card {
                card.position = location
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            if let card = atPoint(location) as? Card {
                card.zPosition = CardLevel.board.rawValue
                card.removeFromParent()
                addChild(card)
                card.removeAction(forKey: "pickup")
                if (abs(card.position.x) > (view?.frame.width)!/1.6 || abs(card.position.y) > (view?.frame.height)!/1.6) && card.faceUp {
                    let newPos = CGPoint(x: card.position.x * 3, y: card.position.y * 3)
                    card.run(SKAction.move(to: newPos, duration: 1), completion: {
                        card.removeFromParent()
                        if let index = deck.index(of: card) {
                            deck.remove(at: index)
                        }
                        label.run(SKAction.fadeAlpha(to: 0.0, duration: 0.5))
                    })
                } else {
                    card.run(SKAction.move(to: card.defaultPos, duration: 0.3))
                    card.run(SKAction.scale(to: 1.0, duration: 0.1), withKey: "drop")
                }
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*for t in touches {
            
        }*/
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
