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
        playerRules = UserDefaults.standard.object(forKey: "rules") as? [String:String] ?? defaultRules
        
        let widthScale = size.width / 1080
        let heightScale = size.height / 1920
        
        let bg = SKSpriteNode(imageNamed: "tableBackground")
        addChild(bg)
        
        let playButton = SCButton(defaultButtonImage: "playButtonDefault", activeButtonImage: "playButtonActive", buttonAction: goToGame)
        let settingsButton = SCButton(defaultButtonImage: "settingsButtonDefault", activeButtonImage: "settingsButtonActive", buttonAction: goToSettings)
        let rulesLabel = SKMultilineLabel(text: "Spelregler: Ställ ett stort glas i mitten av bordet och se till att alla har något drickbart. Tryck på knappen till vänster för att börja spela, ni behöver bara följa beskrivningarna som dyker upp. Vill du sätta dina egna regler så kan du göra det genom att trycka på den högra knappen.", labelWidth: Int(1000 * widthScale), pos: CGPoint(x: 0, y: 20 * heightScale), fontName: "Avenir-Heavy", fontSize: 30, fontColor: UIColor(colorLiteralRed: 69.0/255, green: 55.0/255, blue: 31.0/255, alpha: 1.0), leading: nil, alignment: .center, shouldShowBorder: false)
        
        playButton.setScale(0.25)
        settingsButton.setScale(0.25)
        
        playButton.position = CGPoint(x: -(265 * widthScale), y: -(600 * heightScale))
        settingsButton.position = CGPoint(x: 265 * widthScale, y: -(600 * heightScale))
        
        let glass = SKSpriteNode(imageNamed: "beer_glass")
        glass.setScale(0.15)
        glass.position = CGPoint(x: 0, y: 500 * heightScale)
        
        let label = SKLabelNode(text: "King's Cup")
        label.fontName = "Avenir-Heavy"
        label.fontSize = 80
        label.fontColor = UIColor(colorLiteralRed: 69.0/255, green: 55.0/255, blue: 31.0/255, alpha: 1.0)
        label.position = glass.position
        
        addChild(rulesLabel)
        addChild(playButton)
        addChild(settingsButton)
        addChild(glass)
        addChild(label)
    }
    
    func goToGame() {
        if let view = view {
            if let scene = SKScene(fileNamed: "GameScene") {
                scene.scaleMode = .fill
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
