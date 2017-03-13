//
//  MenuScene.swift
//  KingsCup
//
//  Created by Scott Crocker on 2017-03-13.
//  Copyright © 2017 Scott Crocker. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        let playButton = SCButton(defaultButtonImage: "playButtonDefault", activeButtonImage: "playButtonActive", buttonAction: goToGame)
        let settingsButton = SCButton(defaultButtonImage: "settingsButtonDefault", activeButtonImage: "settingsButtonActive", buttonAction: goToSettings)
        
        addChild(playButton)
        addChild(settingsButton)
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
        if let view = view {
            if let scene = SKScene(fileNamed: "SettingsScene") {
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
