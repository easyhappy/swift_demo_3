//
//  GameScene.swift
//  TestSpritekit
//
//  Created by andyhu on 15/5/19.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import SpriteKit


func + (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x + right.x, y: left.y + right.y)
}
 
func - (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x - right.x, y: left.y - right.y)
}
 
func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x * scalar, y: point.y * scalar)
}
 
func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x / scalar, y: point.y / scalar)
}
 
#if !(arch(x86_64) || arch(arm64))
func sqrt(a: CGFloat) -> CGFloat {
  return CGFloat(sqrtf(Float(a)))
}
#endif
 
extension CGPoint {
  func length() -> CGFloat {
    return sqrt(x*x + y*y)
  }
 
  func normalized() -> CGPoint {
    return self / length()
  }
}

import AVFoundation
 
var backgroundMusicPlayer: AVAudioPlayer!
 
func playBackgroundMusic(filename: String) {
  let url = NSBundle.mainBundle().URLForResource(
    filename, withExtension: nil)
  if (url == nil) {
    println("Could not find file: \(filename)")
    return
  }
 
  var error: NSError? = nil
  backgroundMusicPlayer = 
    AVAudioPlayer(contentsOfURL: url, error: &error)
  if backgroundMusicPlayer == nil {
    println("Could not create audio player: \(error!)")
    return
  }
 
  backgroundMusicPlayer.numberOfLoops = -1
  backgroundMusicPlayer.prepareToPlay()
  backgroundMusicPlayer.play()
}

struct PhysicsCategory {
  static let None      : UInt32 = 0
  static let All       : UInt32 = UInt32.max
  static let Monster   : UInt32 = 0b1       // 1
  static let Projectile: UInt32 = 0b10      // 2
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    let player = SKSpriteNode(imageNamed: "player")
    var monstersDestroyed = 0
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = SKColor.whiteColor()
        playBackgroundMusic("background-music-aac.caf")
        player.position = CGPoint(x: size.width*0.1, y: size.height*0.5)
        addChild(player)
        physicsWorld.gravity = CGVectorMake(9, 9)
        physicsWorld.contactDelegate = self
        runAction(SKAction.repeatActionForever(
          SKAction.sequence([
            SKAction.runBlock(addMonster),
            SKAction.waitForDuration(1.0)
          ])
        ))
    }

    func random() -> CGFloat {
      return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
     
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
      return random() * (max - min) + min
    }
     
    func addMonster() {
     
      // Create sprite
      let monster = SKSpriteNode(imageNamed: "monster")
      monster.physicsBody = SKPhysicsBody(rectangleOfSize: monster.size) // 1
      monster.physicsBody?.dynamic = true // 2
        monster.physicsBody?.categoryBitMask = PhysicsCategory.Monster // 3
        monster.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile // 4
        monster.physicsBody?.collisionBitMask = PhysicsCategory.None // 5
     
      // Determine where to spawn the monster along the Y axis
      let actualY = random(min: monster.size.height/2, max: size.height - monster.size.height/2)
     
      // Position the monster slightly off-screen along the right edge,
      // and along a random position along the Y axis as calculated above
      monster.position = CGPoint(x: size.width + monster.size.width/2, y: actualY)
     
      // Add the monster to the scene
      addChild(monster)
     
      // Determine speed of the monster
      let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
     
      // Create the actions
      let actionMove = SKAction.moveTo(CGPoint(x: -monster.size.width/2, y: actualY), duration: NSTimeInterval(actualDuration))
      let actionMoveDone = SKAction.removeFromParent()
        let loseAction = SKAction.runBlock() {
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            let gameOverScene = GameOverScene(size: self.size, won: false)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }
        monster.runAction(SKAction.sequence([actionMove, loseAction, actionMoveDone]))
     
    }
    func projectileDidCollideWithMonster(projectile:SKSpriteNode, monster:SKSpriteNode) {
  println("Hit")
  projectile.removeFromParent()
  monster.removeFromParent()
        monstersDestroyed++
        if (monstersDestroyed > 500) {
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            let gameOverScene = GameOverScene(size: self.size, won: true)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }
}
    func didBeginContact(contact: SKPhysicsContact) {
 
  // 1
  var firstBody: SKPhysicsBody
  var secondBody: SKPhysicsBody
  if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
    firstBody = contact.bodyA
    secondBody = contact.bodyB
  } else {
    firstBody = contact.bodyB
    secondBody = contact.bodyA
  }
 
  // 2
  if ((firstBody.categoryBitMask & PhysicsCategory.Monster != 0) &&
      (secondBody.categoryBitMask & PhysicsCategory.Projectile != 0)) {
    projectileDidCollideWithMonster(firstBody.node as! SKSpriteNode, monster: secondBody.node as! SKSpriteNode)
  }
 
}
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
 
  // Determine where to spawn the monster along the Y axis
         // for touch in (touches as! Set<UITouch>) {
        //     let location = touch.locationInNode(self)
            
        //     let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
        //     sprite.xScale = 0.5
        //     sprite.yScale = 0.5
        //     sprite.position = location
            
        //     let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
        //     sprite.runAction(SKAction.repeatActionForever(action))
            
        //     self.addChild(sprite)
        // }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
      // 1 - Choose one of the touches to work with
      let touch = touches.first as! UITouch
      let touchLocation = touch.locationInNode(self)
      runAction(SKAction.playSoundFileNamed("pew-pew-lei.caf", waitForCompletion: false))
     
      // 2 - Set up initial location of projectile
      let projectile = SKSpriteNode(imageNamed: "projectile")
      projectile.position = player.position
      projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width/2)
    projectile.physicsBody?.dynamic = true
    projectile.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
    projectile.physicsBody?.contactTestBitMask = PhysicsCategory.Monster
    projectile.physicsBody?.collisionBitMask = PhysicsCategory.None
    projectile.physicsBody?.usesPreciseCollisionDetection = true
      // 3 - Determine offset of location to projectile
      let offset = touchLocation - projectile.position
     
      // 4 - Bail out if you are shooting down or backwards
      if (offset.x < 0) { return }
     
      // 5 - OK to add now - you've double checked position
      addChild(projectile)
     
      // 6 - Get the direction of where to shoot
      let direction = offset.normalized()
     
      // 7 - Make it shoot far enough to be guaranteed off screen
      let shootAmount = direction * 1000
     
      // 8 - Add the shoot amount to the current position
      let realDest = shootAmount + projectile.position
      // 这个 怎么 斜着 移动
      // 9 - Create the actions
      let actionMove = SKAction.moveTo(realDest, duration: 2.0)
      let actionMoveDone = SKAction.removeFromParent()
      projectile.runAction(SKAction.sequence([actionMove, actionMoveDone]))
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
