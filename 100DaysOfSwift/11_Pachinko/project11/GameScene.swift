//
//  GameScene.swift
//  project11
//
//  Created by Furkan DURSUN on 21.04.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var scoreLabel: SKLabelNode!
    var leftBallLabel: SKLabelNode!
    
    var whereBox = [CGPoint]()
    var location = CGPoint(x: 0, y: 0)
    var balls = ["ballBlue", "ballCyan", "ballGrey", "ballGreen", "ballPurple", "ballRed", "ballYellow"]
    
    var leftBall = 5 {
        didSet {
            leftBallLabel.text = "Left Ball: \(leftBall)"
        }
    }
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var editLabel: SKLabelNode!
    
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }
    override func didMove(to view: SKView) {
       let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        leftBallLabel = SKLabelNode(fontNamed: "Chalkduster")
        leftBallLabel.text = "Left Ball: 5"
        leftBallLabel.horizontalAlignmentMode = .center
        leftBallLabel.position = CGPoint(x: 512, y: 700)
        addChild(leftBallLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self

        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        location = touch.location(in: self)
        whereBox.append(location)
        let objects = nodes(at: location)
        
        if objects.contains(editLabel) {
            editingMode.toggle()
        } else {
            if leftBall > 0 {
                if editingMode {
                    let size = CGSize(width: Int.random(in: 16...128), height: 16)
                    let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                    box.zRotation = CGFloat.random(in: 0...3)
                    box.name = "box"
                    box.position = location
                    box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                    box.physicsBody?.isDynamic = false
                    addChild(box)
                } else {
                    let random = Int.random(in: 0...6)
                    let ball = SKSpriteNode(imageNamed: balls[random])
                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
                    ball.physicsBody?.restitution = 0.4
                    ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                    ball.position = CGPoint(x: location.x, y: 768)
                    ball.name = "ball"
                    addChild(ball)
            //        let box = SKSpriteNode(color: .red, size: CGSize(width: 64, height: 64))
            //        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
            //        box.position = location
            //        addChild(box)
                }
            }
        }
    }
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        slotBase.position = position
        slotGlow.position = position
         
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    func collision(between ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball)
            score += 1
            leftBall += 1
        } else if object.name == "bad"{
            destroy(ball: ball)
            score -= 1
            leftBall -= 1
            gameOver()
        } else if object.name == "box" {
            destroy(box: object)
        }
    }
    
    func destroy(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        ball.removeFromParent()
    }
    
    func destroy(box: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = box.position
            addChild(fireParticles)
        }
        box.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }

        if nodeA.name == "ball" {
            collision(between: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collision(between: nodeB, object: nodeA)
        }
    }
    
    func gameOver() {
        if leftBall < 1 {
            let ac = UIAlertController(title: "Oops!", message: "Do you want to play again", preferredStyle: .alert)
            let NewGame = UIAlertAction(title: "New Game", style: .default) { _ in
                self.newGame()
            }
            ac.addAction(NewGame)
            
            DispatchQueue.main.async {
                self.view?.window?.rootViewController?.present(ac, animated: true, completion: nil)
            }
            
        }
    }
    
    @objc func newGame() {
        score = 0
        leftBall = 5

    }
}
