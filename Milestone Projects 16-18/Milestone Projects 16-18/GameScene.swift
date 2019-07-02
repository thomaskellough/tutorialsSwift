//
//  GameScene.swift
//  Milestone Projects 16-18
//
//  Created by Thomas Kellough on 7/2/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var background: SKSpriteNode!
    var curtains: SKSpriteNode!
    var waterbg: SKSpriteNode!
    var waterfg: SKSpriteNode!
    var shots: SKSpriteNode!
    var countdownLabel: SKLabelNode!
    var secondsRemaining = 10 {
        didSet {
            countdownLabel.text = "Time: \(secondsRemaining)"
        }
    }
    var countdownTimer: Timer?
    var speedIncrease = false
    var scaleDecrease = false
    var flip = true
    var moveRight = false
    var shotsList = ["shots3", "shots2", "shots1", "shots0"]
    var shotsIterator = 0 {
        didSet {
            shots.removeFromParent()
            shots = SKSpriteNode(imageNamed: shotsList[shotsIterator])
            shots.position = CGPoint(x: 64, y: 32)
            shots.name = "reload"
            addChild(shots)
            if shotsIterator == 3 {
                run(SKAction.playSoundFileNamed("empty.wav", waitForCompletion: false))
            }
        }
    }
    var possibleTargets = ["target1", "target2", "target3"]
    var gameTimer: Timer?
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var isGameOver = false
    
    override func didMove(to view: SKView) {
        
        background = SKSpriteNode(imageNamed: "wood-background")
        background.position = CGPoint(x: 512, y: 384)
        background.scale(to: CGSize(width: 1024, height: 768))
        addChild(background)
        background.zPosition = -4
        
        curtains = SKSpriteNode(imageNamed: "curtains")
        curtains.position = CGPoint(x: 512, y: 384)
        curtains.scale(to: CGSize(width: 1024, height: 768))
        curtains.zPosition = -1
        addChild(curtains)
        
        waterbg = SKSpriteNode(imageNamed: "water-bg")
        waterbg.position = CGPoint(x: 512, y: 256)
        waterbg.scale(to: CGSize(width: 1024, height: 320))
        waterbg.zPosition = -3
        addChild(waterbg)
        
        waterfg = SKSpriteNode(imageNamed: "water-fg")
        waterfg.position = CGPoint(x: 512, y: 128)
        waterfg.scale(to: CGSize(width: 1024, height: 320))
        waterfg.zPosition = -2
        addChild(waterfg)
        
        shots = SKSpriteNode(imageNamed: shotsList[shotsIterator])
        shots.position = CGPoint(x: 64, y: 32)
        addChild(shots)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.fontSize = 48
        scoreLabel.position = CGPoint(x: 900, y: 700)
        addChild(scoreLabel)
        
        countdownLabel = SKLabelNode(fontNamed: "Chalkduster")
        countdownLabel.text = "Time: 60"
        countdownLabel.fontSize = 48
        countdownLabel.position = CGPoint(x: 110, y: 700)
        addChild(countdownLabel)
        
        physicsWorld.gravity = .zero
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(createTarget), userInfo: nil, repeats: true)
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        gameTimer?.tolerance = 2
    }
    
    @objc func updateTime() {
        secondsRemaining -= 1
        if secondsRemaining == 0 { isGameOver = true }
        if isGameOver {
            countdownTimer?.invalidate()
            gameTimer?.invalidate()
            let gameOver = SKSpriteNode(imageNamed: "game-over")
            gameOver.position = CGPoint(x: 512, y: 384)
            gameOver.zPosition = 1
            addChild(gameOver)
        }
    }
    
    @objc func createTarget() {
        guard let target = possibleTargets.randomElement() else { return }
        let randomYPositions = [400, 300, 200]
        guard let randomYPosition = randomYPositions.randomElement() else { return }
        let chance = Int.random(in: 1...10)
        
        if randomYPosition == 300 {
            flip = false
            moveRight = true
        }
        if chance <= 3 {
            speedIncrease = true
            scaleDecrease = true
        }
        
        let sprite = SKSpriteNode(imageNamed: target)
        sprite.zPosition = 1
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.collisionBitMask = 0
        scaleTarget(sprite: sprite)
        moveBy(sprite: sprite, randomYPosition: randomYPosition)
        if target == "target3" {
            sprite.name = "goodTarget"
        }
        addChild(sprite)
        resetSpriteBools()
    }
    
    func resetSpriteBools() {
        flip = true
        moveRight = false
        speedIncrease = false
        scaleDecrease = false
    }
    
    func moveBy(sprite: SKSpriteNode, randomYPosition: Int) {
        switch (flip, speedIncrease) {
        case (true, true):
            sprite.position = CGPoint(x: -176, y: randomYPosition)
            sprite.physicsBody?.velocity = CGVector(dx: 750 / 3, dy: 0)
        case (true, false):
            sprite.position = CGPoint(x: -176, y: randomYPosition)
            sprite.physicsBody?.velocity = CGVector(dx: 500 / 3, dy: 0)
        case (false, true):
            sprite.position = CGPoint(x: 1200, y: randomYPosition)
            sprite.physicsBody?.velocity = CGVector(dx: -750 / 3, dy: 0)
        case (false, false):
            sprite.position = CGPoint(x: 1200, y: randomYPosition)
            sprite.physicsBody?.velocity = CGVector(dx: -500 / 3, dy: 0)
        }
    }
    
    func scaleTarget(sprite: SKSpriteNode) {
        let xScaleNormal = 0.8
        let xScaleSmall = 0.5
        let yScaleNormal = 0.8
        let yScaleSmall = 0.5
        
        switch (flip, scaleDecrease) {
        case (false, true):
            sprite.xScale = CGFloat(xScaleSmall * -1)
            sprite.yScale = CGFloat(yScaleSmall)
            sprite.name = "fastTarget"
        case (false, false):
            sprite.xScale = CGFloat(xScaleNormal * -1)
            sprite.yScale = CGFloat(yScaleNormal)
            sprite.name = "slowTarget"
        case (true, true):
            sprite.xScale = CGFloat(xScaleSmall)
            sprite.yScale = CGFloat(yScaleSmall)
            sprite.name = "fastTarget"
        case (true, false):
            sprite.xScale = CGFloat(xScaleNormal)
            sprite.xScale = CGFloat(yScaleNormal)
            sprite.name = "slowTarget"
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        
        for node in tappedNodes {
            if shotsIterator < 3 {
                if node.name == "fastTarget" {
                    node.removeFromParent()
                    score += 2
                    run(SKAction.playSoundFileNamed("shot.wav", waitForCompletion: false))
                    shotsIterator += 1
                } else if node.name == "slowTarget" {
                    node.removeFromParent()
                    score += 1
                    run(SKAction.playSoundFileNamed("shot.wav", waitForCompletion: false))
                    shotsIterator += 1
                } else if node.name == "goodTarget" {
                    node.removeFromParent()
                    score -= 1
                    run(SKAction.playSoundFileNamed("shot.wav", waitForCompletion: false))
                    shotsIterator += 1
                }
            }
            if node.name == "reload" {
                reloadGun()
            }
        }
    }
    
    func reloadGun() {
        shotsIterator = 0
        shots.removeFromParent()
        shots = SKSpriteNode(imageNamed: shotsList[shotsIterator])
        shots.position = CGPoint(x: 64, y: 32)
        run(SKAction.playSoundFileNamed("reload.wav", waitForCompletion: false))
        addChild(shots)
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < -300 || node.position.x > 1500 {
                node.removeFromParent()
            }
        }
    }
}
