//
//  WhackSlot.swift
//  Project 14 - HWS Whack-A-Penguin
//
//  Created by Thomas Kellough on 6/26/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import SpriteKit
import UIKit

class WhackSlot: SKNode {  // Must add import SpriteKit
    
    var charNode: SKSpriteNode!
    var mudParticles: SKEmitterNode!
    var smokeEmitter: SKEmitterNode!
    var isVisible = false
    var isHit = false
    
    func configure(at position: CGPoint) {
        self.position = position
        
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        cropNode.addChild(charNode)
        
        addChild(cropNode)
    }
    
    func show(hideTime: Double) {
        if isVisible { return }
        
        charNode.xScale = 1
        charNode.yScale = 1
        
        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
        isVisible = true
        isHit = false
        
        mudParticles = SKEmitterNode(fileNamed: "mudEmitter.sks")
        mudParticles?.position = charNode.position
        mudParticles.run(SKAction.moveBy(x: 0, y: 70, duration: 0.05))
        addChild(mudParticles!)
        
        if Int.random(in: 0...2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        } else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5), execute: {
            [weak self] in
            self?.hide()
        })
    }
    
    func hide() {
        if !isVisible { return }
        
        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
        isVisible = false
    }
    
    func hit() {
        isHit = true
        
        let delay = SKAction.wait(forDuration: 0.25)
        let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
        let notVisible = SKAction.run {
            [weak self] in
            self?.isVisible = false
        }
        smokeEmitter = SKEmitterNode(fileNamed: "smokeEmitter.sks")
        smokeEmitter?.position = charNode.position
        smokeEmitter.zPosition = 1
        addChild(smokeEmitter)
        
        let sequence = SKAction.sequence([delay, hide, notVisible])
        charNode.run(sequence)
    }
}
