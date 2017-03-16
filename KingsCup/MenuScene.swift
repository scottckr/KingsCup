//
//  MenuScene.swift
//  KingsCup
//
//  Created by Scott Crocker on 2017-03-13.
//  Copyright © 2017 Scott Crocker. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        let bg = SKSpriteNode(imageNamed: "tableBackground")
        addChild(bg)
        
        let playButton = SCButton(defaultButtonImage: "playButtonDefault", activeButtonImage: "playButtonActive", buttonAction: goToGame)
        let settingsButton = SCButton(defaultButtonImage: "settingsButtonDefault", activeButtonImage: "settingsButtonActive", buttonAction: goToSettings)
        
        playButton.setScale(0.25)
        settingsButton.setScale(0.25)
        
        playButton.position = CGPoint(x: -(view.frame.width/2), y: -(view.frame.height/2))
        settingsButton.position = CGPoint(x: view.frame.width/2, y: -(view.frame.height/2))
        
        let glass = SKSpriteNode(imageNamed: "beer_glass")
        glass.setScale(0.15)
        glass.position = CGPoint(x: 0, y: view.frame.height/2)
        
        let label = SKLabelNode(text: "King's Cup")
        label.fontName = "Avenir-Heavy"
        label.fontSize = 80
        label.fontColor = UIColor(colorLiteralRed: 69.0/255, green: 55.0/255, blue: 31.0/255, alpha: 1.0)
        label.position = CGPoint(x: 0, y: view.frame.height/2)
        
        addChild(playButton)
        addChild(settingsButton)
        addChild(glass)
        addChild(label)
    }
    
    func goToGame() {
        if let view = view {
            if let scene = SKScene(fileNamed: "GameScene") {
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
        }
    }
    
    func goToSettings() {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let settingsViewController = storyboard.instantiateViewController(withIdentifier: "Settings")
        self.view?.window?.rootViewController?.present(settingsViewController, animated: false, completion: nil)
    }
}
