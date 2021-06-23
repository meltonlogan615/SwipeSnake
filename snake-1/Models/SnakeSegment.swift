//
//  Snake.swift
//  snake-1
//
//  Created by Logan Melton on 21/5/2.
//

import Foundation
import SpriteKit

class SnakeSegment: SKSpriteNode {
  var segmentColor:    CGColor = UIColor.cyan.cgColor
  var segmentSize:      CGSize = CGSize(width: 20, height: 20)
  var speedMultiplier: CGFloat = 1.0
  var length:              Int = 0 // number of snakeSegments
  var currentVelocity: CGVector!
 
  init() {
    super.init(texture: nil, color: UIColor(cgColor: self.segmentColor), size: self.segmentSize)
    self.name = "snake"
    
    self.physicsBody = SKPhysicsBody(rectangleOf: self.segmentSize)
    
    self.physicsBody?.categoryBitMask = PhysicsCategories.snake
    self.physicsBody?.contactTestBitMask = 1
    self.physicsBody?.collisionBitMask = PhysicsCategories.none
    
    self.physicsBody?.restitution = 1
    self.physicsBody?.allowsRotation = false
    self.physicsBody?.isDynamic = true
    self.physicsBody?.linearDamping = 0
    self.physicsBody?.angularDamping = 0
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
