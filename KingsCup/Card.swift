//
//  Card.swift
//  KingsCup
//
//  Created by Scott Crocker on 2017-03-09.
//  Copyright © 2017 Scott Crocker. All rights reserved.
//

import SpriteKit

enum Suit {
    case H, D, C, S
    
    static let allSuits = [H, D, C, S]
}

class Card : SKSpriteNode {
    let suit : Suit
    let value : Int
    let backTexture : SKTexture = SKTexture(imageNamed: "card_back")
    var isOnTop : Bool = false
    var defaultPos = CGPoint(x: 0, y: 0)
    var frontTexture : SKTexture = SKTexture()
    
    var faceUp = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init (suit: Suit, value: Int) {
        self.suit = suit
        self.value = value
        
        super.init(texture: backTexture, color: .clear, size: backTexture.size())
        
        switch suit {
        case .H:
            frontTexture = SKTexture(imageNamed: "\(getValue(value))_of_hearts")
        case .D:
            frontTexture = SKTexture(imageNamed: "\(getValue(value))_of_diamonds")
        case .C:
            frontTexture = SKTexture(imageNamed: "\(getValue(value))_of_clubs")
        case .S:
            frontTexture = SKTexture(imageNamed: "\(getValue(value))_of_spades")
        }
    }
    
    func getValue(_ value: Int) -> String {
        switch value {
        case 1: return "ace"
        case 11: return "jack"
        case 12: return "queen"
        case 13: return "king"
        default: return "\(value)"
        }
    }
    
    func flip() {
        let firstHalfFlip = SKAction.scaleX(to: 0.0, duration: 0.3)
        let secondHalfFlip = SKAction.scaleX(to: 1.0, duration: 0.3)
        
        setScale(1.0)
        
        if !faceUp {
            run(firstHalfFlip) {
                self.texture = self.frontTexture
                self.run(SKAction.playSoundFileNamed("card_draw.wav", waitForCompletion: false))
                self.run(secondHalfFlip)
            }
            faceUp = !faceUp
        }
    }
}
